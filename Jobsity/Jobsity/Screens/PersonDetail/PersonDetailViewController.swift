//
//  PersonDetailViewController.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/01/22.
//

import UIKit

protocol PersonDetailViewControllerDelegate: AnyObject {
    func didSelectTVShow(_ sender: PersonDetailViewController, tvShow: TVShow, isFavorite: Bool)
}

final class PersonDetailViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: PersonDetailViewControllerDelegate?
    private let person: Person
    private let tvShowProvider: TVShowProviderProtocol
    private let favoritesProvider: FavoritesProvider
    private var tvShows = [TVShow]()
    private var favoriteTVShows = [TVShow]()
    
    // MARK: - View Properties
    private lazy var personDetailView: PersonDetailView = {
        let view = PersonDetailView(model: .init(image: person.image?.original ?? ""))
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(person: Person, tvShowProvider: TVShowProviderProtocol, favoritesProvider: FavoritesProvider) {
        self.person = person
        self.tvShowProvider = tvShowProvider
        self.favoritesProvider = favoritesProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LoadView
    override func loadView() {
        self.view = personDetailView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = person.name
        requestTvShows()
    }
    
    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestFavorites()
    }
}

// MARK: - Private methods
private extension PersonDetailViewController {
    func requestFavorites() {
        do {
            self.favoriteTVShows = try favoritesProvider.retrieveFavoriteTvShows()
            self.personDetailView.setupFavoriteTVShows(TVShowFactory.createViewModel(model: self.favoriteTVShows))
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func requestTvShows() {
        self.tvShowProvider.requestTVShows(personId: person.id) { [weak self] result in
            switch result {
                case let .success(tvShows):
                    guard let self = self else { return }
                    self.tvShows = tvShows
                    self.personDetailView.setupTVShows(TVShowFactory.createViewModel(model: tvShows))
                case let .failure(error): print(error.localizedDescription)
            }
        }
    }
}

// MARK: - PersonDetailViewDelegate
extension PersonDetailViewController: PersonDetailViewDelegate {
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
            self.personDetailView.setupFavoriteTVShows(TVShowFactory.createViewModel(model: self.favoriteTVShows))
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
