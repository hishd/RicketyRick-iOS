//
//  CharacterRepositoryLocal.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

class CharacterRepositoryLocal: CharacterRepository {
    func fetchCharacter(by id: Int, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        return nil
    }
    
    func fetchCharacters(from page: Int?, completion: @escaping CompletionHandlerPage) -> (any Cancellable)? {
        return nil
    }
    
    func searchCharacters(by name: String, from page: Int?, completion: @escaping CompletionHandlerPage) -> (any Cancellable)? {
        return nil
    }
    
    func getCharacterData(by urls: [URL], completion: @escaping (Result<[Character], any Error>) -> Void) -> (any Cancellable)? {
        return nil
    }
    
}
