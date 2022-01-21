//
//  EpisodeDetailViewController.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/01/22.
//

import UIKit

final class EpisodeDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let episode: Episode
    
    // MARK: - View Properties
    private lazy var episodeDetailView: EpisodeDetailView = {
        let view = EpisodeDetailView(model: .init(season: episode.season,
                                                  number: episode.number,
                                                  summary: episode.summary,
                                                  poster: episode.image.original))
        
        return view
    }()
    
    // MARK: - Init
    init(episode: Episode) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LoadView
    override func loadView() {
        self.view = episodeDetailView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = episode.name
    }
}
