//
//  FavoritesViewController.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/01/22.
//

import UIKit

protocol FavoritesViewControllerDelegate: AnyObject {
    func didSelectTVShow(_ sender: FavoritesViewController, tvShow: TVShow, isFavorite: Bool)
}

final class FavoritesViewController: UIViewController {
    
    // MARK: - View Properties
    weak var delegate: FavoritesViewControllerDelegate?
    private let favoritesProvider: FavoritesProviderProtocol
    private var tvShows = [TVShow]()
    private lazy var favoritesView: FavoritesView = {
        let view = FavoritesView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(favoritesProvider: FavoritesProviderProtocol) {
        self.favoritesProvider = favoritesProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LoadView
    override func loadView() {
        self.view = favoritesView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.favorites.localized
        requestFavorites()
    }
}

// MARK: - Private methods
private extension FavoritesViewController {
    func requestFavorites() {
        do {
            self.tvShows = try favoritesProvider.retrieveFavoriteTvShows()
            self.favoritesView.setupTVShows(TVShowFactory.createViewModel(model: self.tvShows.sorted(by: { $0.name < $1.name })))
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

// MARK: - FavoritesViewDelegate
extension FavoritesViewController: FavoritesViewDelegate {
    func didSelectTVShow(with id: Int) {
        guard let tvShow = tvShows.first(where: { $0.id == id }) else { return }
        self.delegate?.didSelectTVShow(self, tvShow: tvShow, isFavorite: true)
    }
    
    func shouldUnfavorite(tvShowId: Int) {
        guard let tvShow = tvShows.first(where: { $0.id == tvShowId }) else { return }
        do {
            self.tvShows = try favoritesProvider.removeFavoriteTVShow(tvShow)
            self.favoritesView.setupTVShows(TVShowFactory.createViewModel(model: self.tvShows.sorted(by: { $0.name < $1.name })))
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
