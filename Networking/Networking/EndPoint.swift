//
//  EndPoint.swift
//  Networking
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Foundation

public protocol EndPoint {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String : String] { get }
    var queryParameters: [String : Any] { get }
    
    func createRequest() -> URLRequest?
}

public extension EndPoint {
    func createRequest() -> URLRequest? {
        guard let urlWithQueryParamaters = url.with(queryParameters: queryParameters) else { return nil }
        
        var request = URLRequest(url: urlWithQueryParamaters)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        return request
    }
}
