//
//  FetchCharacterUseCase.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-12.
//

import Foundation

class FetchCharacterUseCase: UseCase {
    let repository: CharacterRepository
    let id: Int
    let completionHandler: (Result<CharacterPage, Error>) -> (Void)
    
    init(repository: CharacterRepository, id: Int, completionHandler: @escaping (Result<CharacterPage, Error>) -> Void) {
        self.repository = repository
        self.id = id
        self.completionHandler = completionHandler
    }
    
    func execute() -> (any Cancellable)? {
        repository.fetchCharacter(by: id, completion: completionHandler)
    }
}
