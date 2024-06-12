//
//  LocationRepository.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

protocol LocationRepository {
    typealias CompletionHandlerPage = (Result<LocationPage, Error>) -> Void
    typealias CompletionHandler = (Result<Location, Error>) -> Void
    func fetchLocation(by id: Int, completion: @escaping CompletionHandler) -> Cancellable?
    func fetchLocations(from page: Int?, completion: @escaping CompletionHandlerPage) -> Cancellable?
    func searchLocations(by name: String, from page: Int?, completion: @escaping CompletionHandlerPage) -> Cancellable?
}
