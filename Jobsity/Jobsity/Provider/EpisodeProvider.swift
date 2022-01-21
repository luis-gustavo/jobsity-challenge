//
//  EpisodeProvider.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Networking

final class EpisodeProvider: EpisodeProviderProtocol {
    
    // MARK: - Properties
    private let networking: Networking
    
    // MARK: - Init
    init(networking: Networking) {
        self.networking = networking
    }
    
    func requestEpisodes(tvShowId: Int, _ completion: @escaping (Result<[Episode], NetworkingError>) -> Void) {
        networking.request(endPoint: TVShowEndpoint.episodes(id: tvShowId)) { result in
            switch result {
                case let .success(response):
                    guard let data = response.data else {
                        completion(.success([]))
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let episodes = try decoder.decode([Episode].self, from: data)
                        completion(.success(episodes))
                    } catch let error {
                        completion(.failure(.unmapped(error)))
                    }
                    
                case let .failure(error): completion(.failure(error))
            }
        }
    }
}
