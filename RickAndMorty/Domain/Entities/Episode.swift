//
//  Episode.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

struct EpisodeCharacter {
    let characterUrl: URL?
}

struct Episode {
    let episodeId: Int
    let episodeName: String
    let airDate: String
    let codeName: String
    let characters: [EpisodeCharacter]
    let createdData: Date?
}

struct EpisodePage {
    let count: Int
    let pages: Int
    let episodes: [Episode]
}
