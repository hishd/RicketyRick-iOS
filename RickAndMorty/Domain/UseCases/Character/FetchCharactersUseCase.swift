//
//  FetchCharactersUseCase.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

final class FetchCharactersUseCase: UseCase {
    
    let repository: CharacterRepository
    let page: Int?
    let completionHandler: (Result<CharacterPage, Error>) -> (Void)
    
    init(repository: CharacterRepository, page: Int? = nil, completionHandler: @escaping (Result<CharacterPage, Error>) -> Void) {
        self.repository = repository
        self.page = page
        self.completionHandler = completionHandler
    }
    
    func execute() -> (any CancellableHttpRequest)? {
        return repository.fetchCharacters(from: page, completion: completionHandler)
    }
}
