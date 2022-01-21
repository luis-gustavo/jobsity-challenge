//
//  TVShow.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Foundation

struct TVShow: Codable, Equatable {
    let id: Int
    let name: String
    let image: Image
    let genres: [String]
    let summary: String
    let schedule: Schedule
    
    struct Schedule: Codable {
        let time: String
        let days: [String]
    }
    
    static func == (lhs: TVShow, rhs: TVShow) -> Bool {
        return lhs.id == rhs.id
    }
}
