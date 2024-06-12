//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

protocol CharacterRepository {
    typealias CompletionHandler = (Result<CharacterPage, Error>) -> Void
    func fetchCharacter(by id: Int, completion: @escaping CompletionHandler) -> Cancellable?
    func fetchCharacters(from page: Int?, completion: @escaping CompletionHandler) -> Cancellable?
    func searchCharacters(by name: String, from page: Int?, completion: @escaping CompletionHandler) -> Cancellable?
}
