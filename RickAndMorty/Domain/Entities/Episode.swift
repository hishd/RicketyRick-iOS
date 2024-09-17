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
    var fullCodeName: String {
        let seasonNumber = codeName.substring(with: 1..<3)
        let episodeNumber = codeName.substring(from: 4)
        return "Season \(seasonNumber), Episode \(episodeNumber)"
    }
}

#if DEBUG
extension Episode {
    static var sample: Episode = .init(
        episodeId: 0,
        episodeName: "Episode",
        airDate: "Date",
        codeName: "Code Name",
        characters: .init(),
        createdData: Date()
    )
}
#endif

struct EpisodePage {
    let count: Int
    let pages: Int
    let episodes: [Episode]
}
