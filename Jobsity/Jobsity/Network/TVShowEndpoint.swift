//
//  TVShowEndpoint.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Networking

enum TVShowEndpoint: EndPoint {
    
    case tvShows
    
    var url: URL {
        switch self {
            case .tvShows:
                guard let url = URL(string: "\(APIKeys.baseUrl)/shows") else { preconditionFailure("The url must exist") }
                return url
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    var queryParameters: [String : Any] {
        return [:]
    }
}
