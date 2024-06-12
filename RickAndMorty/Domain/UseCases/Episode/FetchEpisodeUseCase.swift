//
//  FetchEpisodeUseCase.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-12.
//

import Foundation

class FetchEpisodeUseCase: UseCase {
    let repository: EpisodeRepository
    let id: Int
    let completionHandler: (Result<Episode, Error>) -> (Void)
    
    init(repository: EpisodeRepository, id: Int, completionHandler: @escaping (Result<Episode, Error>) -> Void) {
        self.repository = repository
        self.id = id
        self.completionHandler = completionHandler
    }
    
    func execute() -> (any Cancellable)? {
        return repository.fetchEpisode(by: id, completion: completionHandler)
    }
}
