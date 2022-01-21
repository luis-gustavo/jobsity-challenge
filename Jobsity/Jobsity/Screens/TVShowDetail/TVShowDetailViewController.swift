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
    private let provider: EpisodeProviderProtocol
    private let tvShow: TVShow
    private var episodes = [Episode]()
    
    // MARK: - View Properties
    private lazy var tvShowDetailView: TVShowDetailView = {
        let view = TVShowDetailView(model: TVShowDetailViewControllerFactory.createViewModel(model: tvShow))
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(tvShow: TVShow, provider: EpisodeProviderProtocol) {
        self.tvShow = tvShow
        self.provider = provider
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
    func requestEpisodes() {
        provider.requestEpisodes(tvShowId: tvShow.id) { [weak self] result in
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
