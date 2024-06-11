//
//  CharacterResponseDTO+Mapping.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

struct CharacterResponseDTO: Decodable {
    let info: InfoDTO
    let results: [ResultsDTO]
}

extension CharacterResponseDTO {
    struct InfoDTO: Decodable {
        let count: Int
        let pages: Int
    }
}

extension CharacterResponseDTO {
    struct ResultsDTO: Decodable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let type: String
        let gender: String
        let origin: OriginDTO
        let location: LocationDTO
        let image: String
        let episode: [String]
        let created: String
    }
}

extension CharacterResponseDTO {
    struct OriginDTO: Decodable {
        let name: String
        let url: String
    }
}

extension CharacterResponseDTO {
    struct LocationDTO: Decodable {
        let name: String
        let url: String
    }
}

//MARK: Domain Entity Mappings

extension CharacterResponseDTO {
    
    static func mapToStatus(status: String) -> CharacterStatus {
        switch status {
        case "Alive": .alive
        case "Dead": .dead
        case "unknown": .unknown
        default: .unknown
        }
    }
    
    func mapToDomain() -> CharacterPage {
        let count = self.info.count
        let pages = self.info.pages
        
        let characters: [Character] = self.results.map { item in
                return .init(
                    characterId: item.id,
                    characterName: item.name,
                    status: CharacterResponseDTO.mapToStatus(status: item.status),
                    species: item.species,
                    type: item.type,
                    gender: item.gender,
                    origin: item.origin.mapToDomain(),
                    lastLocation: item.location.mapToDomain(),
                    imageUrl: URL(string: item.image),
                    episodes: mapStringsToUrl(urlStrings: item.episode),
                    createdData: ISO8601DateFormatter().date(from: item.created)
                )
        }
        
        return CharacterPage(count: count, pages: pages, characters: characters)
    }
}

extension CharacterResponseDTO.OriginDTO {
    func mapToDomain() -> CharacterOrigin {
        
        let url = URL(string: self.url)
        
        return .init(originName: self.name, locationUrl: url)
    }
}

extension CharacterResponseDTO.LocationDTO {
    func mapToDomain() -> CharacterLastLocation {
        
        let url = URL(string: self.url)
        
        return .init(locationName: self.name, locationUrl: url)
    }
}


