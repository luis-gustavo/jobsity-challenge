//
//  Localizable.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Foundation

enum Localizable {
    case tvShows
    case genres
    case schedule
    case summary
    case season
    case episodes
    case episode
    case favorites
    case people
    case search
    case authentication
    case isAuthenticationEnabled
    case reopenAndTryAgain
    case unableToDecodeError
    case unableToEncodeError
    
    var localized: String {
        switch self {
            case .tvShows: return "TV_SHOWS".localize()
            case .genres: return "GENRES".localize()
            case .schedule: return "SCHEDULE".localize()
            case .summary: return "SUMMARY".localize()
            case .season: return "SEASON".localize()
            case .episodes: return "EPISODES".localize()
            case .episode: return "EPISODE".localize()
            case .favorites: return "FAVORITES".localize()
            case .people: return "PEOPLE".localize()
            case .search: return "SEARCH".localize()
            case .authentication: return "AUTHENTICATION".localize()
            case .isAuthenticationEnabled: return "IS_AUTHENTICATION_ENABLED".localize()
            case .reopenAndTryAgain: return "REOPEN_APP_TRY_AGAIN".localize()
            case .unableToEncodeError: return "UNABLE_TO_ENCODE".localize()
            case .unableToDecodeError: return "UNABLE_TO_DECODE".localize()
        }
    }
}

// MARK: - Localize
fileprivate extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localize(with arguments: [CVarArg]) -> String {
        return String(format: self.localize(), arguments: arguments)
    }
}
