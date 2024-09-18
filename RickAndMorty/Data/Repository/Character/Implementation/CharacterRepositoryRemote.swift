//
//  CharacterRepositoryRemote.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

class CharacterRepositoryRemote: CharacterRepository {
    
    let networkDataTransferService: NetworkDataTransferService
    
    init(networkDataTransferService: NetworkDataTransferService) {
        self.networkDataTransferService = networkDataTransferService
    }
    
    func fetchCharacter(by id: Int, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        let endpoint = CharacterEndpoints.getCharacter(by: id)
        
        return buildRequest(with: endpoint, completion: completion)
    }
    
    func fetchCharacters(from page: Int?, completion: @escaping CompletionHandlerPage) -> (any Cancellable)? {
        
        let endpoint = CharacterEndpoints.allCharacters(from: page)
        
        return buildRequest(with: endpoint, completion: completion)
    }
    
    func searchCharacters(by name: String, from page: Int?, completion: @escaping CompletionHandlerPage) -> (any Cancellable)? {
        let endpoint = CharacterEndpoints.searchCharacters(by: name, from: page)
        
        return buildRequest(with: endpoint, completion: completion)
    }
    
    func getCharacterData(by urls: [URL], completion: @escaping (Result<[Character], any Error>) -> Void) -> (any Cancellable)? {
        let endpoints: [ApiEndpoint] = urls.map { url in
            return CharacterEndpoints.getCharacter(by: url)
        }
        
        let task = CancellableTaskCollection()
        task.isNetworkTask = true
        
        task.networkTasks = networkDataTransferService.request(with: endpoints, completion: { result in
            
            let handler: Result<[Character], Error>
            
            defer {
                completion(handler)
            }
            
            switch result {
            case .success(let response):
                let characters: [Character] = response.results.map { character in
                    return character.mapToDomain()
                }
                handler = .success(characters)
                task.isSuccessful = true
            case .failure(let error):
                handler = .failure(error)
            }
        })
        
        return task
    }
    
    private func buildRequest(with endpoint: ApiEndpoint<CharacterResponseDTO>, completion: @escaping CompletionHandlerPage) -> (any Cancellable)? {
        let task = CancellableTask()
        task.isNetworkTask = true
        
        task.networkTask = networkDataTransferService.request(with: endpoint) { result in
            let handler: (Result<CharacterPage, Error>)
            
            defer {
                completion(handler)
            }
            
            switch result {
            case .success(let result):
                handler = .success(result.mapToDomain())
                task.isSuccessful = true
            case .failure(let error):
                handler = .failure(error)
            }
        }
        
        return task
    }
    
    private func buildRequest(with endpoint: ApiEndpoint<CharacterResponseDTO.ResultsDTO>, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        let task = CancellableTask()
        task.isNetworkTask = true
        
        task.networkTask = networkDataTransferService.request(with: endpoint) { result in
            let handler: (Result<Character, Error>)
            
            defer {
                completion(handler)
            }
            
            switch result {
            case .success(let result):
                handler = .success(result.mapToDomain())
                task.isSuccessful = true
            case .failure(let error):
                handler = .failure(error)
            }
        }
        
        return task
    }
}
