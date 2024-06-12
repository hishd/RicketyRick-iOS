//
//  EpisodeRepositoryLocal.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-12.
//

import Foundation

class EpisodeRepositoryLocal: EpisodeRepository {
    func fetchEpisodes(from page: Int?, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        nil
    }
    
    func searchEpisodes(by name: String, from page: Int?, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        nil
    }
}
