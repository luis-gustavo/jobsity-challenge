//
//  TVShowsViewController.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

protocol TVShowsViewControllerDelegate: AnyObject {
    func didSelectTVShow(_ sender: TVShowsViewController, tvShow: TVShow, isFavorite: Bool)
    func didSelectFavorites()
}

final class TVShowsViewController: UIViewController {

    // MARK: - Properties
    weak var delegate: TVShowsViewControllerDelegate?
    private let tvShowProvider: TVShowProviderProtocol
    private let favoritesProvider: FavoritesProviderProtocol
    private var tvShows = [TVShow]()
    private var favoriteTVShows = [TVShow]()
    
    // MARK: - View Properties
    private lazy var tvShowsView: TVShowsView = {
        let view = TVShowsView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(tvShowProvider: TVShowProviderProtocol, favoritesProvider: FavoritesProviderProtocol) {
        self.tvShowProvider = tvShowProvider
        self.favoritesProvider = favoritesProvider
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
        setupFavoritesButton()
        requestTvShows()
    }
    
    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestFavorites()
    }
}

// MARK: - TVShowsViewDelegate
extension TVShowsViewController: TVShowsViewDelegate {
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
    
    func requestTvShows() {
        self.tvShowProvider.requestTVShows { [weak self] result in
            switch result {
                case let .success(tvShows):
                    guard let self = self else { return }
                    self.tvShows = tvShows
                    self.tvShowsView.setupTvShows(TVShowFactory.createViewModel(model: tvShows))
                case let .failure(error): print(error.localizedDescription)
            }
        }
    }
}
