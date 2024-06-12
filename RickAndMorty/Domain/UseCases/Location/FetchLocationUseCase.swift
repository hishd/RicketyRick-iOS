//
//  FetchLocationUseCase.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

final class FetchLocationUseCase: UseCase {
    let repository: LocationRepository
    let page: Int?
    let completionHandler: (Result<LocationPage, Error>) -> (Void)
    
    init(repository: LocationRepository, page: Int? = nil, completionHandler: @escaping (Result<LocationPage, Error>) -> Void) {
        self.repository = repository
        self.page = page
        self.completionHandler = completionHandler
    }
    
    func execute() -> (any Cancellable)? {
        return repository.fetchLocations(from: page, completion: completionHandler)
    }
}
