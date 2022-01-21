//
//  FavoritesProvider.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/01/22.
//

import Foundation

final class FavoritesProvider: FavoritesProviderProtocol {
    
    // MARK: - Init
    private init() { }
    
    // MARK: - Properties
    static let shared = FavoritesProvider()
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "com.luisgustavo.Jobsity.favorites"
    private var favorites = [TVShow]()
    
    func saveFavoriteTVShow(_ tvShow: TVShow) throws -> [TVShow] {
        do {
            favorites.append(tvShow)
            let data = try JSONEncoder().encode(favorites)
            userDefaults.set(data, forKey: favoritesKey)
            return favorites
        } catch {
            throw FavoritesProviderError.unableToEncode
        }
    }
    
    func removeFavoriteTVShow(_ tvShow: TVShow) throws -> [TVShow] {
        do {
            favorites.removeAll(where: { $0 == tvShow })
            let data = try JSONEncoder().encode(favorites)
            userDefaults.set(data, forKey: favoritesKey)
            return favorites
        } catch {
            throw FavoritesProviderError.unableToEncode
        }
    }
    
    func retrieveFavoriteTvShows() throws -> [TVShow]  {
        do {
            if let favoritesData = userDefaults.data(forKey: favoritesKey) {
                let favorites = try JSONDecoder().decode([TVShow].self, from: favoritesData)
                self.favorites = favorites
                return self.favorites
            } else {
                return []
            }
        } catch {
            throw FavoritesProviderError.unableToDecode
        }
    }
}

enum FavoritesProviderError: Error, LocalizedError, CustomStringConvertible, Hashable {
    case unableToEncode
    case unableToDecode
    
    var description: String {
        switch self {
            case .unableToEncode: return Localizable.unableToEncodeError.localized
            case .unableToDecode: return Localizable.unableToDecodeError.localized
        }
    }
}
