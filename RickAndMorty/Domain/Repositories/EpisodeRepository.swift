//
//  EpisodeRepository.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

protocol EpisodeRepository {
    typealias CompletionHandlerPage = (Result<EpisodePage, Error>) -> Void
    typealias CompletionHandler = (Result<Episode, Error>) -> Void
    func fetchEpisode(by id: Int, completion: @escaping CompletionHandler) -> Cancellable?
    func fetchEpisodes(from page: Int?, completion: @escaping CompletionHandlerPage) -> Cancellable?
    func searchEpisodes(by name: String, from page: Int?, completion: @escaping CompletionHandlerPage) -> Cancellable?
    func getEpisodeData(by urls: [URL], completion: @escaping (Result<[Episode], Error>) -> Void) -> Cancellable?
}
