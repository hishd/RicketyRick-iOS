//
//  LocationEndpoints.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

enum LocationEndpoints {
    static func allLocations() -> ApiEndpoint<LocationResponseDTO> {
        .init(path: "location", method: .get)
    }
    
    static func searchLocations(by name: String) -> ApiEndpoint<LocationResponseDTO> {
        .init(path: "location", method: .get, queryParameters: ["name": name])
    }
}
