//
//  LocationResponseDTO+Mapping.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

struct LocationResponseDTO: Decodable {
    let info: InfoDTO
    let results: [ResultsDTO]
}

extension LocationResponseDTO {
    struct InfoDTO: Decodable {
        let count: Int
        let pages: Int
    }
}

extension LocationResponseDTO {
    struct ResultsDTO: Decodable {
        let id: Int
        let name: String
        let type: String
        let dimension: String
        let residents: [String]
        let created: String
    }
}

//MARK: Domain Entity Mappings

extension LocationResponseDTO {
    
    static func mapToLocationResidents(from residentUrls: [String]) -> [LocationResident] {
        return residentUrls.map { item in
            return .init(characterUrl: URL(string: item))
        }
    }
    
    func mapToDomain() -> LocationPage {
        let count = self.info.count
        let pages = self.info.pages
        
        let locations: [Location] = self.results.map { item in
            return .init(
                locationId: item.id,
                locationName: item.name,
                locationType: item.type,
                dimension: item.dimension,
                residents: LocationResponseDTO.mapToLocationResidents(from: item.residents),
                createdData: ISO8601DateFormatter().date(from: item.created)
            )
        }
        
        return .init(count: count, pages: pages, locations: locations)
    }
}

extension LocationResponseDTO.ResultsDTO {
    func mapToDomain() -> Location {
        .init(
            locationId: self.id,
            locationName: self.name,
            locationType: self.type,
            dimension: self.dimension,
            residents: LocationResponseDTO.mapToLocationResidents(from: self.residents),
            createdData: ISO8601DateFormatter().date(from: self.created)
        )
    }
}
