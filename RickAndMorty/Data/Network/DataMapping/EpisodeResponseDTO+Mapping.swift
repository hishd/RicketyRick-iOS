//
//  EpisodeResponseDTO+Mapping.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

struct EpisodeResponseDTO: Decodable {
    let info: InfoDTO
    let results: [ResultsDTO]
}

extension EpisodeResponseDTO {
    struct InfoDTO: Decodable {
        let count: Int
        let pages: Int
    }
}

extension EpisodeResponseDTO {
    struct ResultsDTO: Decodable {
        let id: Int
        let name: String
        let air_date: String
        let episode: String
        let characters: [String]
        let created: String
    }
}

//MARK: Domain Entity Mappings

extension EpisodeResponseDTO {
    
    static func mapToCharacters(from characters: [String]) -> [EpisodeCharacter] {
        return characters.map { item in
            return .init(characterUrl: URL(string: item))
        }
    }
    
    func mapToDomain() -> EpisodePage {
        let count = self.info.count
        let pages = self.info.pages
        
        let episodes: [Episode] = self.results.map { item in
            return .init(
                episodeId: item.id,
                episodeName: item.name,
                airDate: item.air_date,
                codeName: item.episode,
                characters: EpisodeResponseDTO.mapToCharacters(from: item.characters),
                createdData: ISO8601DateFormatter().date(from: item.created)
            )
        }
        
        return .init(count: count, pages: pages, episodes: episodes)
    }
}

extension EpisodeResponseDTO.ResultsDTO {
    func mapToDomain() -> Episode {
        .init(
            episodeId: self.id,
            episodeName: self.name,
            airDate: self.air_date,
            codeName: self.episode,
            characters: EpisodeResponseDTO.mapToCharacters(from: self.characters),
            createdData: ISO8601DateFormatter().date(from: self.created)
        )
    }
}
