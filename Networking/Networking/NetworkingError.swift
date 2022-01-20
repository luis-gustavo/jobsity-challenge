//
//  NetworkingError.swift
//  Networking
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Foundation

public enum NetworkingError: Error, LocalizedError, CustomStringConvertible, Hashable {
    case queryParameters(URL, [String : Any])
    case unmapped(Error)
    case notHTTPURLResponse
    case unknownStatusCode(Int)

    public var description: String {
        switch self {
            case let .queryParameters(url, parameters): return Localizable.unableToCreateQueryParameters(url, parameters).localized
            case let .unmapped(error): return error.localizedDescription
            case .notHTTPURLResponse: return Localizable.notHTTPUrlResponse.localized
            case let .unknownStatusCode(statusCode): return Localizable.unknownStatusCode(statusCode).localized
        }
    }
    
    public static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(localizedDescription)
    }
}
