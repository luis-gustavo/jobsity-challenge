//
//  TVShowProviderProtocol.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Networking

protocol TVShowProviderProtocol {
    func requestTVShows(page: Int, _ completion: @escaping (Result<[TVShow], NetworkingError>) -> Void)
    func requestTVShows(query: String, _ completion: @escaping (Result<[TVShow], NetworkingError>) -> Void)
    func requestTVShows(personId: Int, _ completion: @escaping (Result<[TVShow], NetworkingError>) -> Void)
}
