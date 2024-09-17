//
//  EpisodeRepositoryLocal.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-12.
//

import Foundation

class EpisodeRepositoryLocal: EpisodeRepository {
    func fetchEpisode(by id: Int, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        nil
    }
    
    func fetchEpisodes(from page: Int?, completion: @escaping CompletionHandlerPage) -> (any Cancellable)? {
        nil
    }
    
    func searchEpisodes(by name: String, from page: Int?, completion: @escaping CompletionHandlerPage) -> (any Cancellable)? {
        nil
    }
    
    func getEpisodeData(by urls: [URL], completion: @escaping (Result<[Episode], any Error>) -> Void) -> (any Cancellable)? {
        nil
    }
}
