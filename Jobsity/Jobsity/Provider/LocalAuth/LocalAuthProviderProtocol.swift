//
//  LocalAuthProviderProtocol.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/01/22.
//

import Foundation

protocol LocalAuthProviderProtocol {
    var isLocalAuthEnabled: Bool { get }
    func setIsLocalAuthEnabled(_ enabled: Bool)
}
