//
//  FetchEpisodesUseCase.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

final class FetchEpisodesUseCase: UseCase {
    let repository: EpisodeRepository
    let page: Int?
    let completionHandler: (Result<EpisodePage, Error>) -> (Void)
    
    init(repository: EpisodeRepository, page: Int? = nil, completionHandler: @escaping (Result<EpisodePage, Error>) -> Void) {
        self.repository = repository
        self.page = page
        self.completionHandler = completionHandler
    }
    
    func execute() -> (any Cancellable)? {
        return repository.fetchEpisodes(from: page, completion: completionHandler)
    }
}
