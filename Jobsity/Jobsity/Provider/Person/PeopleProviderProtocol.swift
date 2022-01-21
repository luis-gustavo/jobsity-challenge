//
//  PersonProviderProtocol.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/01/22.
//

import Networking

protocol PeopleProviderProtocol {
    func requestPeople(query: String, completion: @escaping (Result<[Person], NetworkingError>) -> Void)
}
