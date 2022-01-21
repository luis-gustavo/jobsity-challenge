//
//  Person.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/01/22.
//

import Foundation

struct Person: Codable, Equatable {
    let id: Int
    let name: String
    let image: Image?
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}
