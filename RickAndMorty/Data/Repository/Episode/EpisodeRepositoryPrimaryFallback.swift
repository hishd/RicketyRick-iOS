//
//  EpisodeRepositoryPrimaryFallback.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-12.
//

import Foundation
import OSLog

class EpisodeRepositoryPrimaryFallback: EpisodeRepository {
    private let primary: EpisodeRepository
    private let fallback: EpisodeRepository
    
    init(primary: EpisodeRepository, fallback: EpisodeRepository) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func fetchEpisodes(from page: Int?, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        var task: Cancellable?
        
        task = primary.fetchEpisodes(from: page, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(_):
                Logger.viewCycle.info("Executing fallback strategy from \(String(describing: EpisodeRepositoryPrimaryFallback.self))")
                task = self?.fallback.fetchEpisodes(from: page, completion: completion)
            }
        })
        
        return task
    }
    
    func searchEpisodes(by name: String, from page: Int?, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        var task: Cancellable?
        
        task = primary.searchEpisodes(by: name, from: page, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(_):
                Logger.viewCycle.info("Executing fallback strategy from \(String(describing: EpisodeRepositoryPrimaryFallback.self))")
                task = self?.fallback.searchEpisodes(by: name, from: page, completion: completion)
            }
        })
        
        return task
    }
}
