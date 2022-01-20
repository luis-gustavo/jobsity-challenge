//
//  TVShowsViewController.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

final class TVShowsViewController: UIViewController {
    
    // MARK: - View Properties
    private let tvShowsView = TVShowsView()
    private let provider: TVShowProviderProtocol
    
    // MARK: - Init
    init(provider: TVShowProviderProtocol) {
        self.provider = provider
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
        requestTvShows()
    }
}

// MARK: - Private methods
private extension TVShowsViewController {
    func requestTvShows() {
        self.provider.requestTVShows { [weak self] result in
            switch result {
                case let .success(tvShows):
                    guard let self = self else { return }
                    self.tvShowsView.setupTvShows(tvShows: TVShowsViewControllerFactory.createViewModel(model: tvShows))
                case let .failure(error): print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Factory
fileprivate struct TVShowsViewControllerFactory {
    static func createViewModel(model: [TVShow]) -> [TVShowsView.Model] {
        return model.map({ .init(id: $0.id, name: $0.name, image: $0.image.medium) })
    }
}
