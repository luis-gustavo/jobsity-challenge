//
//  TVShowProvider.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Networking

final class TVShowProvider: TVShowProviderProtocol {
    
    // MARK: - Properties
    private let networking: Networking
    
    // MARK: - Init
    init(networking: Networking) {
        self.networking = networking
    }
    
    func requestTVShows(_ completion: @escaping (Result<[TVShow], NetworkingError>) -> Void) {
        networking.request(endPoint: TVShowEndpoint.tvShows) { result in
            switch result {
                case let .success(response):
                    guard let data = response.data else {
                        completion(.success([]))
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let tvShows = try decoder.decode([TVShow].self, from: data)
                        completion(.success(tvShows))
                    } catch let error {
                        completion(.failure(.unmapped(error)))
                    }
                    
                case let .failure(error): completion(.failure(error))
            }
        }
    }
}
