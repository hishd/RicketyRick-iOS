//
//  FetchEpisodesByURLUseCase.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-09-17.
//

import Foundation

class GetEpisodesByUrlsUseCase: UseCase {
    
    let repository: EpisodeRepository
    let urls: [URL]
    let completionHandler: (Result<[Episode], Error>) -> Void
    
    init(repository: EpisodeRepository, urls: [URL], completionHandler: @escaping (Result<[Episode], Error>) -> Void) {
        self.repository = repository
        self.urls = urls
        self.completionHandler = completionHandler
    }
    
    func execute() -> (any Cancellable)? {
        return repository.getEpisodeData(by: urls, completion: completionHandler)
    }
}
