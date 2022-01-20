//
//  Localizable.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Foundation

enum Localizable {
    case tvShows
    
    var localized: String {
        switch self {
            case .tvShows: return "TV_SHOWS".localize()
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
