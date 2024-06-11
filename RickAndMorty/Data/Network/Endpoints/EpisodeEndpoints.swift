//
//  EpisodeEndpoints.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

enum EpisodeEndpoints {
    static func allEpisodes() -> ApiEndpoint<EpisodeResponseDTO> {
        .init(path: "episode", method: .get)
    }
    
    static func searchEpisodes(by name: String) -> ApiEndpoint<EpisodeResponseDTO> {
        .init(path: "episode", method: .get, queryParameters: ["name": name])
    }
}
