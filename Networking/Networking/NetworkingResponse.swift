//
//  NetworkingResponse.swift
//  Networking
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Foundation

public struct NetworkingResponse: Hashable {
    public let data: Data?
    public let status: HTTPStatusCode
    public let request: URLRequest
    
    public init(data: Data?, status: HTTPStatusCode, request: URLRequest) {
        self.data = data
        self.status = status
        self.request = request
    }
}
