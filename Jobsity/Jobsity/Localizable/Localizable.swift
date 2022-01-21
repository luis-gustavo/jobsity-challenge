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
    
    var localized: String {
        switch self {
            case .tvShows: return "TV_SHOWS".localize()
            case .genres: return "GENRES".localize()
            case .schedule: return "SCHEDULE".localize()
            case .summary: return "SUMMARY".localize()
            case .season: return "SEASON".localize()
            case .episodes: return "EPISODES".localize()
            case .episode: return "EPISODE".localize()
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
