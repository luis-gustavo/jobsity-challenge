//
//  TVShowsViewController.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

protocol TVShowsViewControllerDelegate: AnyObject {
    func didSelectTVShow(_ sender: TVShowsViewController, tvShow: TVShow, isFavorite: Bool)
    func didSelectPerson(_ sender: TVShowsViewController, person: Person)
    func didSelectFavorites()
}

final class TVShowsViewController: UIViewController {

    // MARK: - Properties
    weak var delegate: TVShowsViewControllerDelegate?
    
    private let tvShowProvider: TVShowProviderProtocol
    private let favoritesProvider: FavoritesProviderProtocol
    private let peopleProvider: PeopleProviderProtocol
    
    private var tvShows = [TVShow]()
    private var favoriteTVShows = [TVShow]()
    private var people = [Person]()
    
    private var currentPage = 0
    private var isFetchInProgress = false
    private var isFiltering = false
    private var isShowingTVShows = true {
        didSet {
            tvShowsView.isShowingTVShows = isShowingTVShows
        }
    }
    
    // MARK: - View Properties
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "\(Localizable.search.localized)..."
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.scopeButtonTitles = [Localizable.tvShows.localized,
                                                        Localizable.people.localized]
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private lazy var tvShowsView: TVShowsView = {
        let view = TVShowsView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(tvShowProvider: TVShowProviderProtocol,
         favoritesProvider: FavoritesProviderProtocol,
         peopleProvider: PeopleProviderProtocol) {
        self.tvShowProvider = tvShowProvider
        self.favoritesProvider = favoritesProvider
        self.peopleProvider = peopleProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LoadView
    override func loadView() {
        self.view = tvShowsView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.tvShows.localized
        navigationItem.searchController = searchController
        setupFavoritesButton()
        requestTvShows(page: 0)
    }
    
    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestFavorites()
    }
}

// MARK: - TVShowsViewDelegate
extension TVShowsViewController: TVShowsViewDelegate {
    func didSelectPerson(with id: Int) {
        guard let person = people.first(where: { $0.id == id }) else { return }
        self.delegate?.didSelectPerson(self, person: person)
    }
    
    func fetchTVShows() {
        guard !isFiltering, isShowingTVShows else { return }
        self.requestTvShows(page: currentPage)
    }
    
    func didSelectTVShow(with id: Int) {
        guard let tvShow = tvShows.first(where: { $0.id == id }) else { return }
        self.delegate?.didSelectTVShow(self, tvShow: tvShow, isFavorite: self.favoriteTVShows.contains(where: { $0 == tvShow }))
    }
    
    func didSelectFavorite(tvShowId: Int, shouldFavorite: Bool) {
        guard let tvShow = tvShows.first(where: { $0.id == tvShowId }) else { return }
        do {
            if shouldFavorite {
                self.favoriteTVShows = try self.favoritesProvider.saveFavoriteTVShow(tvShow)
            } else {
                self.favoriteTVShows = try self.favoritesProvider.removeFavoriteTVShow(tvShow)
            }
            self.tvShowsView.setupFavoriteTVShows(TVShowFactory.createViewModel(model: self.favoriteTVShows))
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Private methods
private extension TVShowsViewController {
    func setupFavoritesButton() {
        let favoriteAction = UIAction { [weak self] action in
            guard let self = self else { return }
            self.delegate?.didSelectFavorites()
        }
        let favoritesButton = UIBarButtonItem(title: Localizable.favorites.localized,
                                              image: nil,
                                              primaryAction: favoriteAction,
                                              menu: nil)
        navigationItem.rightBarButtonItem = favoritesButton
    }
    
    func requestFavorites() {
        do {
            self.favoriteTVShows = try favoritesProvider.retrieveFavoriteTvShows()
            self.tvShowsView.setupFavoriteTVShows(TVShowFactory.createViewModel(model: self.favoriteTVShows))
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func requestTvShows(page: Int) {
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        self.tvShowProvider.requestTVShows(page: page) { [weak self] result in
            switch result {
                case let .success(tvShows):
                    guard let self = self else { return }
                    self.isFetchInProgress = false
                    self.currentPage += 1
                    self.tvShows = tvShows
                    self.tvShowsView.appendTVShows(TVShowFactory.createViewModel(model: tvShows))
                case let .failure(error):
                    guard let self = self else { return }
                    self.isFetchInProgress = false
                    print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UISearchResultsUpdating
extension TVShowsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) { }
}

// MARK: -
extension TVShowsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
            case 0:
                self.isShowingTVShows = true
                self.searchBar(searchBar, textDidChange: searchBar.text ?? "")
            case 1:
                self.isShowingTVShows = false
                self.searchBar(searchBar, textDidChange: searchBar.text ?? "")
            default: break
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        isFiltering = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if isShowingTVShows {
            guard !isFetchInProgress else { return }
            isFetchInProgress = true
            tvShowProvider.requestTVShows(query: searchText) { [weak self] result in
                switch result {
                    case let .success(tvShows):
                        guard let self = self else { return }
                        self.isFetchInProgress = false
                        self.tvShows = tvShows
                        self.tvShowsView.setupTVShows(TVShowFactory.createViewModel(model: tvShows))
                    case let .failure(error):
                        guard let self = self else { return }
                        self.isFetchInProgress = false
                        print(error.localizedDescription)
                }
            }
        } else {
            guard !isFetchInProgress else { return }
            isFetchInProgress = true
            peopleProvider.requestPeople(query: searchText) { [weak self] result in
                switch result {
                    case let .success(people):
                        guard let self = self else { return }
                        self.isFetchInProgress = false
                        self.people = people
                        self.tvShowsView.setupPeople(PersonFactory.createViewModel(model: self.people))
                    case let .failure(error):
                        guard let self = self else { return }
                        self.isFetchInProgress = false
                        print(error.localizedDescription)
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
        
        if searchBar.selectedScopeButtonIndex == 0 {
            isFiltering = false
            currentPage = 0
            self.tvShowsView.setupTVShows([])
            fetchTVShows()
        }
    }
}
