//
//  SearchLocationsUseCase.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

final class SearchLocationsUseCase: UseCase {
    
    let repository: LocationRepository
    let page: Int?
    let name: String
    let completionHandler: (Result<LocationPage, Error>) -> (Void)
    
    init(repository: LocationRepository, page: Int? = nil, name: String, completionHandler: @escaping (Result<LocationPage, Error>) -> Void) {
        self.repository = repository
        self.page = page
        self.name = name
        self.completionHandler = completionHandler
    }
    
    func execute() -> (any Cancellable)? {
        return repository.searchLocations(by: name, from: page, completion: completionHandler)
    }
}
