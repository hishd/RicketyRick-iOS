//
//  FetchLocationUseCase.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-12.
//

import Foundation

final class FetchLocationUseCase: UseCase {
    let repository: LocationRepository
    let id: Int
    let completionHandler: (Result<Location, Error>) -> (Void)
    
    init(repository: LocationRepository, id: Int, completionHandler: @escaping (Result<Location, Error>) -> Void) {
        self.repository = repository
        self.id = id
        self.completionHandler = completionHandler
    }
    
    func execute() -> (any Cancellable)? {
        return repository.fetchLocation(by: id, completion: completionHandler)
    }
}
