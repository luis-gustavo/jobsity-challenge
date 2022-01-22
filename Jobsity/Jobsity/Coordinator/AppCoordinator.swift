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
    private let shouldAuthenticate: Bool
    private let navigationController: UINavigationController
    
    // MARK: - Init
    init(navigationController: UINavigationController, shouldAuthenticate: Bool) {
        self.navigationController = navigationController
        self.shouldAuthenticate = shouldAuthenticate
    }
    
    // MARK: - Start
    func start() {
        if shouldAuthenticate {
            let viewController = LocalAuthViewController()
            viewController.modalPresentationStyle = .overFullScreen
            viewController.delegate = self
            self.navigationController.present(viewController, animated: true, completion: nil)
        } else {
            let viewController = TVShowsViewController(tvShowProvider: TVShowProvider(networking: URLSessionNetworking.shared),
                                                       favoritesProvider: FavoritesProvider.shared,
                                                       peopleProvider: PeopleProvider(networking: URLSessionNetworking.shared))
            viewController.delegate = self
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - TVShowsViewControllerDelegate
extension AppCoordinator: TVShowsViewControllerDelegate {
    func didSelectAuthentication() {
        let viewController = SetupAuthViewController(localAuthProvider: LocalAuthProvider.shared)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func didSelectPerson(_ sender: TVShowsViewController, person: Person) {
        let viewController = PersonDetailViewController(person: person,
                                                        tvShowProvider: TVShowProvider(networking: URLSessionNetworking.shared),
                                                        favoritesProvider: FavoritesProvider.shared)
        viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func didSelectFavorites() {
        let viewController = FavoritesViewController(favoritesProvider: FavoritesProvider.shared)
        viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func didSelectTVShow(_ sender: TVShowsViewController, tvShow: TVShow, isFavorite: Bool) {
        let viewController = TVShowDetailViewController(tvShow: tvShow,
                                                        episodeProvider: EpisodeProvider(networking: URLSessionNetworking.shared),
                                                        favoritesProvider: FavoritesProvider.shared,
                                                        isFavorite: isFavorite)
        viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - TVShowDetailViewControllerDelegate
extension AppCoordinator: TVShowDetailViewControllerDelegate {
    func didSelectEpisode(_ episode: Episode) {
        let viewController = EpisodeDetailViewController(episode: episode)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - FavoritesViewControllerDelegate
extension AppCoordinator: FavoritesViewControllerDelegate {
    func didSelectTVShow(_ sender: FavoritesViewController, tvShow: TVShow, isFavorite: Bool) {
        let viewController = TVShowDetailViewController(tvShow: tvShow,
                                                        episodeProvider: EpisodeProvider(networking: URLSessionNetworking.shared),
                                                        favoritesProvider: FavoritesProvider.shared,
                                                        isFavorite: isFavorite)
        viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - PersonDetailViewControllerDelegate
extension AppCoordinator: PersonDetailViewControllerDelegate {
    func didSelectTVShow(_ sender: PersonDetailViewController, tvShow: TVShow, isFavorite: Bool) {
        let viewController = TVShowDetailViewController(tvShow: tvShow,
                                                        episodeProvider: EpisodeProvider(networking: URLSessionNetworking.shared),
                                                        favoritesProvider: FavoritesProvider.shared,
                                                        isFavorite: isFavorite)
        viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - LocalAuthViewControllerDelegate
extension AppCoordinator: LocalAuthViewControllerDelegate {
    func didAuthenticate() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.navigationController.dismiss(animated: false) { [weak self] in
                guard let self = self else { return }
                let viewController = TVShowsViewController(tvShowProvider: TVShowProvider(networking: URLSessionNetworking.shared),
                                                           favoritesProvider: FavoritesProvider.shared,
                                                           peopleProvider: PeopleProvider(networking: URLSessionNetworking.shared))
                viewController.delegate = self
                self.navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
}
