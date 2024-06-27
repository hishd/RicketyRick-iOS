//
//  MockCharacterDataRepository.swift
//  RickAndMortyTests
//
//  Created by Hishara Dilshan on 2024-06-12.
//

import Foundation
@testable import RickAndMorty

enum MockCharacterRepositoryError: Error {
    case decodingError
    case notFound
}

final class MockCharacterRepository: CharacterRepository {
    
    var url: URL? {
        let bundle = Bundle(for: MockCharacterRepository.self)
        return bundle.url(forResource: "characters", withExtension: "json")
    }
    
    func fetchCharacter(by id: Int, completion: @escaping CompletionHandler) -> (any RickAndMorty.Cancellable)? {
        guard let fileUrl = url else {
            fatalError("Could not generate character file url")
        }
        
        let completionHandler: Result<Character, Error>
        
        defer {
            completion(completionHandler)
        }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let result = try JSONDecoder().decode(CharacterResponseDTO.self, from: data)
            let characters = result.mapToDomain()
            
            let filteredCharacter = characters.characters.first {
                $0.characterId == id
            }
            
            guard let filteredCharacter = filteredCharacter else {
                completionHandler = .failure(MockCharacterRepositoryError.notFound)
                return nil
            }
            
            completionHandler = .success(filteredCharacter)
        } catch {
            completionHandler = .failure(MockCharacterRepositoryError.decodingError)
        }
        
        return nil
    }
    
    func fetchCharacters(from page: Int?, completion: @escaping CompletionHandlerPage) -> (any RickAndMorty.Cancellable)? {
        guard let fileUrl = url else {
            fatalError("Could not generate character file url")
        }
        
        let completionHandler: Result<CharacterPage, Error>
        
        defer {
            completion(completionHandler)
        }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let result = try JSONDecoder().decode(CharacterResponseDTO.self, from: data)
            let characters = result.mapToDomain()
            
            completionHandler = .success(characters)
        } catch {
            completionHandler = .failure(MockCharacterRepositoryError.decodingError)
        }
        
        return nil
    }
    
    func searchCharacters(by name: String, from page: Int?, completion: @escaping CompletionHandlerPage) -> (any RickAndMorty.Cancellable)? {
        guard let fileUrl = url else {
            fatalError("Could not generate character file url")
        }
        
        let completionHandler: Result<CharacterPage, Error>
        
        defer {
            completion(completionHandler)
        }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let result = try JSONDecoder().decode(CharacterResponseDTO.self, from: data)
            let characterPage = result.mapToDomain()
            
            let filteredCharacters = characterPage.characters.filter { character in
                character.characterName.lowercased().contains(name.lowercased())
            }
            
            let newPage: CharacterPage = .init(
                count: characterPage.count,
                pages: characterPage.pages,
                characters: filteredCharacters
            )
            
            completionHandler = .success(newPage)
        } catch {
            completionHandler = .failure(MockCharacterRepositoryError.decodingError)
        }
        
        return nil
    }
}
