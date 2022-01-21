//
//  TVShowDetailViewController.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

protocol TVShowDetailViewControllerDelegate: AnyObject {
    func didSelectEpisode(_ episode: Episode)
}

final class TVShowDetailViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: TVShowDetailViewControllerDelegate?
    private let episodeProvider: EpisodeProviderProtocol
    private let favoritesProvider: FavoritesProviderProtocol
    private let tvShow: TVShow
    private var episodes = [Episode]()
    private var isFavorite: Bool
    
    // MARK: - View Properties
    private lazy var tvShowDetailView: TVShowDetailView = {
        let view = TVShowDetailView(model: TVShowDetailViewControllerFactory.createViewModel(model: tvShow))
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(tvShow: TVShow, episodeProvider: EpisodeProviderProtocol, favoritesProvider: FavoritesProviderProtocol, isFavorite: Bool) {
        self.tvShow = tvShow
        self.episodeProvider = episodeProvider
        self.favoritesProvider = favoritesProvider
        self.isFavorite = isFavorite
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LoadView
    override func loadView() {
        self.view = tvShowDetailView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = tvShow.name
        setupFavoritesButton()
        requestEpisodes()
    }
}

// MARK: - TVShowDetailViewDelegate
extension TVShowDetailViewController: TVShowDetailViewDelegate {
    func didSelectEpisode(with id: Int) {
        guard let episode = episodes.first(where: { $0.id == id }) else { return }
        self.delegate?.didSelectEpisode(episode)
    }
}

// MARK: - Private methods
private extension TVShowDetailViewController {
    func setupFavoritesButton() {
        let favoriteAction = UIAction { [weak self] action in
            guard let self = self else { return }
            do {
                if self.isFavorite {
                    _ = try self.favoritesProvider.removeFavoriteTVShow(self.tvShow)
                    self.isFavorite = false
                    self.navigationItem.rightBarButtonItem?.image = .init(systemName: "star")
                } else {
                    _ = try self.favoritesProvider.saveFavoriteTVShow(self.tvShow)
                    self.isFavorite = true
                    self.navigationItem.rightBarButtonItem?.image = .init(systemName: "star.fill")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        let favoritesButton = UIBarButtonItem(title: nil,
                                              image: .init(systemName: isFavorite ? "star.fill" : "star"),
                                              primaryAction: favoriteAction,
                                              menu: nil)
        navigationItem.rightBarButtonItem = favoritesButton
    }
    
    func requestEpisodes() {
        episodeProvider.requestEpisodes(tvShowId: tvShow.id) { [weak self] result in
            switch result {
                case let .success(episodes):
                    guard let self = self else { return }
                    self.episodes = episodes
                    self.tvShowDetailView.setupEpisodes(TVShowDetailViewControllerFactory.createViewEpisodes(episodes: episodes))
                case let .failure(error): print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Factory
fileprivate struct TVShowDetailViewControllerFactory {
    static func createViewModel(model: TVShow) -> TVShowDetailView.Model {
        return .init(poster: model.image.original,
                     days: model.schedule.days,
                     time: model.schedule.time,
                     genres: model.genres,
                     summary: model.summary)
    }
    
    static func createViewEpisodes(episodes: [Episode]) -> [TVShowDetailView.Episode] {
        return episodes.map({ .init(id: $0.id,
                                    season: $0.season,
                                    number: $0.number,
                                    name: $0.name,
                                    image: $0.image.medium) })
    }
}
