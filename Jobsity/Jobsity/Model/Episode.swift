//
//  Episode.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let summary: String?
    let image: Image?
}
