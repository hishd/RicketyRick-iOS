//
//  LocationRepositoryLocal.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-12.
//

import Foundation

class LocationRepositoryLocal: LocationRepository {
    func fetchLocations(from page: Int?, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        nil
    }
    
    func searchLocations(by name: String, from page: Int?, completion: @escaping CompletionHandler) -> (any Cancellable)? {
        nil
    }
}
