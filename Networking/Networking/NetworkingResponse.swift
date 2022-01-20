//
//  NetworkingResponse.swift
//  Networking
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Foundation

public struct NetworkingResponse: Hashable {
    let data: Data?
    let status: HTTPStatusCode
    let request: URLRequest
    
    init(data: Data?, status: HTTPStatusCode, request: URLRequest) {
        self.data = data
        self.status = status
        self.request = request
    }
}
