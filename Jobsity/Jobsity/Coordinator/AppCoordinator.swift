//
//  AppCoordinator.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Networking
import UIKit

final class AppCoordinator: Coordinatable {
    
    // MARK: - Properties
    private let navigationController: UINavigationController
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Start
    func start() {
        let viewController = TVShowsViewController(provider: TVShowProvider(networking: URLSessionNetworking()))
        viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - TVShowsViewControllerDelegate
extension AppCoordinator: TVShowsViewControllerDelegate {
    func didSelectTVShow(_ tvShow: TVShow) {
        let viewController = TVShowDetailViewController(tvShow: tvShow, provider: EpisodeProvider(networking: URLSessionNetworking()))
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
