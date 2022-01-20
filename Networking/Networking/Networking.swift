//
//  Networking.swift
//  Networking
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Foundation

public protocol Networking {
    func request(endPoint: EndPoint, _ completion: @escaping (Result<NetworkingResponse, NetworkingError>) -> Void)
}
