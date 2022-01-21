//
//  PersonFactory.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/01/22.
//

import Foundation

struct PersonFactory {
    private init() { }
    
    static func createViewModel(model: [Person]) -> [PersonViewModel] {
        return model.map({ .init(id: $0.id,
                                 name: $0.name,
                                 image: $0.image?.medium ?? "") })
    }
}
