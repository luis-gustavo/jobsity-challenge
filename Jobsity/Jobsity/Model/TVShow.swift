//
//  TVShow.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Foundation

struct TVShow: Codable {
    let id: Int
    let name: String
    let image: Image
    
    struct Image: Codable {
        let medium: String
        let original: String
    }
}
