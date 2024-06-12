//
//  LocationRepository.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

protocol LocationRepository {
    typealias CompletionHandler = (Result<LocationPage, Error>) -> Void
    func fetchLocation(by id: Int, completion: @escaping CompletionHandler) -> Cancellable?
    func fetchLocations(from page: Int?, completion: @escaping CompletionHandler) -> Cancellable?
    func searchLocations(by name: String, from page: Int?, completion: @escaping CompletionHandler) -> Cancellable?
}
