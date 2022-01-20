//
//  URL+withQueryParameters.swift
//  Networking
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Foundation

extension URL {
    func with(queryParameters: [String : Any]) -> URL? {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryParameters.map { entry in URLQueryItem(name: entry.key, value: "\(entry.value)") }
        guard let urlWithQueryParamaters = urlComponents?.url else { return nil }
        return urlWithQueryParamaters
    }
}
