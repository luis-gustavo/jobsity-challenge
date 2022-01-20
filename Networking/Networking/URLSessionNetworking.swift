//
//  URLSessionNetworking.swift
//  Networking
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Foundation

public struct URLSessionNetworking: Networking {
    
    public init() { } 
    
    public func request(endPoint: EndPoint, _ completion: @escaping (Result<NetworkingResponse, NetworkingError>) -> Void) {
        
        guard let request = endPoint.createRequest() else {
            completion(.failure(.queryParameters(endPoint.url, endPoint.queryParameters)))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.unmapped(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.notHTTPURLResponse))
                return
            }
            
            guard let statusCode = HTTPStatusCode(rawValue: httpResponse.statusCode) else { completion(.failure(.unknownStatusCode(httpResponse.statusCode)))
                return
            }
            
            completion(.success(.init(data: data, status: statusCode, request: request)))
        }
        dataTask.resume()
    }
}
