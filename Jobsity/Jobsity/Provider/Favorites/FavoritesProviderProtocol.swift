//
//  FavoritesProviderProtocol.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/01/22.
//

import Foundation

protocol FavoritesProviderProtocol {
    func saveFavoriteTVShow(_ tvShow: TVShow) throws -> [TVShow]
    func removeFavoriteTVShow(_ tvShow: TVShow) throws -> [TVShow]
    func retrieveFavoriteTvShows() throws -> [TVShow]
}
