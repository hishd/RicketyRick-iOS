//
//  LocationRepositoryPrimaryFallback.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-12.
//

import Foundation
import OSLog

class LocationRepositoryPrimaryFallback: LocationRepository {
    
    private let primary: LocationRepository
    private let fallback: LocationRepository
    
    init(primary: LocationRepository, fallback: LocationRepository) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func fetchLocations(from page: Int?, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        var task: Cancellable?
        
        task = primary.fetchLocations(from: page, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(_):
                Logger.viewCycle.info("Executing fallback strategy from \(String(describing: LocationRepositoryPrimaryFallback.self))")
                task = self?.fallback.fetchLocations(from: page, completion: completion)
            }
        })
        
        return task
    }
    
    func searchLocations(by name: String, from page: Int?, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        var task: Cancellable?
        
        task = primary.searchLocations(by: name, from: page, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(_):
                Logger.viewCycle.info("Executing fallback strategy from \(String(describing: CharacterRepositoryPrimaryFallback.self))")
                task = self?.fallback.searchLocations(by: name, from: page, completion: completion)
            }
        })
        
        return task
    }
}
