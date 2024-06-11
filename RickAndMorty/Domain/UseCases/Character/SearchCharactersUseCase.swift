//
//  SearchCharactersUseCase.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

final class SearchCharactersUseCase: UseCase {
    
    let repository: CharacterRepository
    let page: Int?
    let name: String
    let completionHandler: (Result<CharacterPage, Error>) -> (Void)
    
    init(repository: CharacterRepository, page: Int? = nil, name: String, completionHandler: @escaping (Result<CharacterPage, Error>) -> Void) {
        self.repository = repository
        self.page = page
        self.name = name
        self.completionHandler = completionHandler
    }
    
    func execute() -> (any CancellableHttpRequest)? {
        return repository.searchCharacters(by: name, from: page, completion: completionHandler)
    }
}
