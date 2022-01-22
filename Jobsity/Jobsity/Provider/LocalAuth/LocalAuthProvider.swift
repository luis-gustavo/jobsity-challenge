//
//  LocalAuthProvider.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/01/22.
//

import Foundation

final class LocalAuthProvider: LocalAuthProviderProtocol {
    
    // MARK: - Properties
    static let shared = LocalAuthProvider()
    private let userDefaults = UserDefaults.standard
    private let localAuthKey = "com.luisgustavo.Jobsity.localAuth"
    
    // MARK: - Init
    private init() { }
    
    // MARK: - LocalAuthProviderProtocol
    var isLocalAuthEnabled: Bool {
        return userDefaults.bool(forKey: localAuthKey)
    }
    
    func setIsLocalAuthEnabled(_ enabled: Bool) {
        userDefaults.set(enabled, forKey: localAuthKey)
    }
}
