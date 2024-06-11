//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

protocol CharacterRepository {
    typealias CompletionHandler = (Result<CharacterPage, Error>) -> Void
    func fetchCharacters(from page: Int?, completion: @escaping CompletionHandler) -> CancellableHttpRequest?
    func searchCharacters(from page: Int?, completion: @escaping CompletionHandler) -> CancellableHttpRequest?
}
