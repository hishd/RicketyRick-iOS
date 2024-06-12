//
//  EpisodeRepositoryRemote.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-12.
//

import Foundation

class EpisodeRepositoryRemote: EpisodeRepository {
    
    let networkDataTransferService: NetworkDataTransferService
    
    init(networkDataTransferService: NetworkDataTransferService) {
        self.networkDataTransferService = networkDataTransferService
    }
    
    func fetchEpisodes(from page: Int?, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        let endpoint = EpisodeEndpoints.allEpisodes(from: page)
        
        return buildRequest(with: endpoint, completion: completion)
    }
    
    func searchEpisodes(by name: String, from page: Int?, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        let endpoint = EpisodeEndpoints.searchEpisodes(by: name, from: page)
        
        return buildRequest(with: endpoint, completion: completion)
    }
    
    private func buildRequest(with endpoint: ApiEndpoint<EpisodeResponseDTO>, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        let task = CancellableTask()
        task.isNetworkTask = true
        
        task.networkTask = networkDataTransferService.request(with: endpoint) { result in
            let handler: (Result<EpisodePage, Error>)
            
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
