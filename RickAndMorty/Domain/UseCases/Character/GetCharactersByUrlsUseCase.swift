//
//  GetCharactersByUrlsUseCase.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-09-18.
//

import Foundation

final class GetCharactersByUrlsUseCase: UseCase {
    let repository: CharacterRepository
    let urls: [URL]
    let completionHandler: (Result<[Character], Error>) -> Void
    
    init(repository: CharacterRepository, urls: [URL], completionHandler: @escaping (Result<[Character], Error>) -> Void) {
        self.repository = repository
        self.urls = urls
        self.completionHandler = completionHandler
    }
    
    func execute() -> (any Cancellable)? {
        return repository.getCharacterData(by: urls, completion: completionHandler)
    }
}
