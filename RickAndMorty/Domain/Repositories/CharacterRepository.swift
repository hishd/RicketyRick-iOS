//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

protocol CharacterRepository {
    typealias CompletionHandlerPage = (Result<CharacterPage, Error>) -> Void
    typealias CompletionHandler = (Result<Character, Error>) -> Void
    func fetchCharacter(by id: Int, completion: @escaping CompletionHandler) -> Cancellable?
    func fetchCharacters(from page: Int?, completion: @escaping CompletionHandlerPage) -> Cancellable?
    func searchCharacters(by name: String, from page: Int?, completion: @escaping CompletionHandlerPage) -> Cancellable?
    func getCharacterData(by urls: [URL], completion: @escaping (Result<[Character], Error>) -> Void) -> Cancellable?
}
