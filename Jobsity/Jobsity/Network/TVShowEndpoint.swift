//
//  TVShowEndpoint.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Networking

enum TVShowEndpoint: EndPoint {
    
    case tvShowsByPage(Int)
    case tvShowsByQuery(String)
    case episodes(id: Int)
    case people(query: String)
    case tvShowsByPersonId(Int)
    
    var url: URL {
        switch self {
            case let .tvShowsByPersonId(id):
                guard let url = URL(string: "\(APIKeys.baseUrl)/people/\(id)/castcredits") else { preconditionFailure("The url must exist") }
                return url
            case .tvShowsByQuery:
                guard let url = URL(string: "\(APIKeys.baseUrl)/search/shows") else { preconditionFailure("The url must exist") }
                return url
            case .tvShowsByPage:
                guard let url = URL(string: "\(APIKeys.baseUrl)/shows") else { preconditionFailure("The url must exist") }
                return url
            case let .episodes(id: id):
                guard let url = URL(string: "\(APIKeys.baseUrl)/shows/\(id)/episodes") else { preconditionFailure("The url must exist") }
                return url
            case .people:
                guard let url = URL(string: "\(APIKeys.baseUrl)/search/people") else { preconditionFailure("The url must exist") }
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
        switch self {
            case let .tvShowsByQuery(query): return ["q": query]
            case let .tvShowsByPage(page): return ["page": page]
            case let .people(query: query): return ["q": query]
            case .tvShowsByPersonId: return ["embed": "show"]
            default: return [:]
        }
    }
}
