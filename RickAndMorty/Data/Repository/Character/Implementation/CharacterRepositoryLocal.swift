//
//  CharacterRepositoryLocal.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

class CharacterRepositoryLocal: CharacterRepository {
    func fetchCharacters(from page: Int?, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        return nil
    }
    
    func searchCharacters(by name: String, from page: Int?, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        return nil
    }
}
