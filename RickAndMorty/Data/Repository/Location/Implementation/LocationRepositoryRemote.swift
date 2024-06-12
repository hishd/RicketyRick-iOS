//
//  LocationRepositoryRemote.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-12.
//

import Foundation

class LocationRepositoryRemote: LocationRepository {
    
    let networkDataTransferService: NetworkDataTransferService
    
    init(networkDataTransferService: NetworkDataTransferService) {
        self.networkDataTransferService = networkDataTransferService
    }
    
    func fetchLocations(from page: Int?, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        let endpoint = LocationEndpoints.allLocations(from: page)
        
        return buildRequest(with: endpoint, completion: completion)
    }
    
    func searchLocations(by name: String, from page: Int?, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        let endpoint = LocationEndpoints.searchLocations(by: name, from: page)
        
        return buildRequest(with: endpoint, completion: completion)
    }
    
    private func buildRequest(with endpoint: ApiEndpoint<LocationResponseDTO>, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        let task = CancellableTask()
        task.isNetworkTask = true
        
        task.networkTask = networkDataTransferService.request(with: endpoint) { result in
            let handler: (Result<LocationPage, Error>)
            
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
