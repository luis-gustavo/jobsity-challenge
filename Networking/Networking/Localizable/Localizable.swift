//
//  Localizable.swift
//  Networking
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Foundation

enum Localizable {
    case unableToCreateQueryParameters(URL, [String: Any])
    case notHTTPUrlResponse
    case unknownStatusCode(Int)
    
    var localized: String {
        switch self {
            case let .unableToCreateQueryParameters(url, dictionary): return "UNABLE_TO_CREATE_QUERY_PARAMETERS".localize(with: [url.absoluteString, dictionary])
            case .notHTTPUrlResponse: return "NOT_HTTPURL_RESPONSE".localize()
            case let .unknownStatusCode(statusCode): return "UNKNOWN_STATUS_CODE".localize(with: [statusCode])
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
