//
//  TVShowProvider.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Networking

fileprivate struct TopLevelBody: Decodable {
    let show: TVShow
}

fileprivate struct EmbeddedBody: Decodable {
    let show: TVShow
    
    private enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
    
    private enum EmbeddedKeys: String, CodingKey {
        case show
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let embeddedContainer = try container.nestedContainer(keyedBy: EmbeddedKeys.self, forKey: .embedded)
        self.show = try embeddedContainer.decode(TVShow.self, forKey: .show)
    }
}

final class TVShowProvider: TVShowProviderProtocol {
    
    // MARK: - Properties
    private let networking: Networking
    
    // MARK: - Init
    init(networking: Networking) {
        self.networking = networking
    }

    // MARK: - TVShowProviderProtocol methods
    func requestTVShows(personId: Int, _ completion: @escaping (Result<[TVShow], NetworkingError>) -> Void) {
        networking.request(endPoint: TVShowEndpoint.tvShowsByPersonId(personId)) { result in
            switch result {
                case let .success(response):
                    guard let data = response.data else {
                        completion(.success([]))
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let embeddedBody = try decoder.decode([EmbeddedBody].self, from: data)
                        completion(.success(embeddedBody.map({ $0.show })))
                    } catch let error {
                        completion(.failure(.unmapped(error)))
                    }
                    
                case let .failure(error): completion(.failure(error))
            }
        }
    }

    func requestTVShows(query: String, _ completion: @escaping (Result<[TVShow], NetworkingError>) -> Void) {
        networking.request(endPoint: TVShowEndpoint.tvShowsByQuery(query)) { result in
            switch result {
                case let .success(response):
                    guard let data = response.data else {
                        completion(.success([]))
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let topLevelBody = try decoder.decode([TopLevelBody].self, from: data)
                        completion(.success(topLevelBody.map({ $0.show })))
                    } catch let error {
                        completion(.failure(.unmapped(error)))
                    }
                    
                case let .failure(error): completion(.failure(error))
            }
        }
    }
    
    func requestTVShows(page: Int, _ completion: @escaping (Result<[TVShow], NetworkingError>) -> Void) {
        networking.request(endPoint: TVShowEndpoint.tvShowsByPage(page)) { result in
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
