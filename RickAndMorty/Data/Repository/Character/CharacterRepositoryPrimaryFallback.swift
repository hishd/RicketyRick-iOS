//
//  CharacterRepositoryPrimaryFallback.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation
import OSLog

class CharacterRepositoryPrimaryFallback: CharacterRepository {
    
    private let primary: CharacterRepository
    private let fallback: CharacterRepository
    
    init(primary: CharacterRepository, fallback: CharacterRepository) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func fetchCharacter(by id: Int, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        var task: Cancellable?
        
        task = primary.fetchCharacter(by: id, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(_):
                Logger.viewCycle.info("Executing fallback strategy from \(String(describing: CharacterRepositoryPrimaryFallback.self))")
                task = self?.fallback.fetchCharacter(by: id, completion: completion)
            }
        })
        
        return task
    }
    
    func fetchCharacters(from page: Int?, completion: @escaping CompletionHandlerPage) -> (any Cancellable)? {
        var task: Cancellable?
        
        task = primary.fetchCharacters(from: page, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(_):
                Logger.viewCycle.info("Executing fallback strategy from \(String(describing: CharacterRepositoryPrimaryFallback.self))")
                task = self?.fallback.fetchCharacters(from: page, completion: completion)
            }
        })
        
        return task
    }
    
    func searchCharacters(by name: String, from page: Int?, completion: @escaping CompletionHandlerPage) -> (any Cancellable)? {
        var task: Cancellable?
        
        task = primary.searchCharacters(by: name, from: page, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(_):
                Logger.viewCycle.info("Executing fallback strategy from \(String(describing: CharacterRepositoryPrimaryFallback.self))")
                task = self?.fallback.searchCharacters(by: name, from: page, completion: completion)
            }
        })
        
        return task
    }
    
    func getCharacterData(by urls: [URL], completion: @escaping (Result<[Character], any Error>) -> Void) -> (any Cancellable)? {
        var task: Cancellable?
        
        task = primary.getCharacterData(by: urls, completion: { [weak self] result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(_):
                Logger.viewCycle.info("Executing fallback strategy from \(String(describing: CharacterRepositoryPrimaryFallback.self))")
                task = self?.fallback.getCharacterData(by: urls, completion: completion)
            }
        })
        
        return task
    }
}
