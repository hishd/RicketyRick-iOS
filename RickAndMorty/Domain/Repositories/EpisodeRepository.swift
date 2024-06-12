//
//  EpisodeRepository.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

protocol EpisodeRepository {
    typealias CompletionHandler = (Result<EpisodePage, Error>) -> Void
    func fetchEpisodes(from page: Int?, completion: @escaping CompletionHandler) -> Cancellable?
    func searchEpisodes(by name: String, from page: Int?, completion: @escaping CompletionHandler) -> Cancellable?
}
