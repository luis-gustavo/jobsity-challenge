//
//  PeopleProvider.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/01/22.
//

import Networking

fileprivate struct TopLevelBody: Codable {
    let person: Person
}

final class PeopleProvider: PeopleProviderProtocol {
    
    // MARK: - Properties
    private let networking: Networking
    
    // MARK: - Init
    init(networking: Networking) {
        self.networking = networking
    }
    
    func requestPeople(query: String, completion: @escaping (Result<[Person], NetworkingError>) -> Void) {
        networking.request(endPoint: TVShowEndpoint.people(query: query)) { result in
            switch result {
                case let .success(response):
                    guard let data = response.data else {
                        completion(.success([]))
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let topLevelBody = try decoder.decode([TopLevelBody].self, from: data)
                        completion(.success(topLevelBody.map({ $0.person })))
                    } catch let error {
                        completion(.failure(.unmapped(error)))
                    }
                case let .failure(error): completion(.failure(error))
            }
        }
    }
}
