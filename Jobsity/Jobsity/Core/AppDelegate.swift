//
//  AppDelegate.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Networking
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let networking: Networking = URLSessionNetworking()
        
        networking.request(endPoint: TVShowEndpoint.tvShows) { result in
            switch result {
                case let .success(response): print(response)
                case let .failure(error): print(error)
            }
        }
        
        return true
    }
}
