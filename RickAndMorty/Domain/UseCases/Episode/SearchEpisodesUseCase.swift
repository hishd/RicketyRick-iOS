//
//  SearchEpisodesUseCase.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

final class SearchEpisodesUseCase: UseCase {
    let repository: EpisodeRepository
    let page: Int?
    let name: String
    let completionHandler: (Result<EpisodePage, Error>) -> (Void)
    
    init(repository: EpisodeRepository, page: Int? = nil, name: String, completionHandler: @escaping (Result<EpisodePage, Error>) -> Void) {
        self.repository = repository
        self.page = page
        self.name = name
        self.completionHandler = completionHandler
    }
    
    func execute() -> (any Cancellable)? {
        return repository.searchEpisodes(by: name, from: page, completion: completionHandler)
    }
}
