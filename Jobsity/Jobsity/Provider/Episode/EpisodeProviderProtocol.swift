//
//  EpisodeProviderProtocol.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import Networking

protocol EpisodeProviderProtocol {
    func requestEpisodes(tvShowId:Int, _ completion: @escaping (Result<[Episode], NetworkingError>) -> Void)
}
