//
//  CharacterEndpoints.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

enum CharacterEndpoints {
    static func allCharacters() -> ApiEndpoint<CharacterResponseDTO> {
        .init(path: "character", method: .get)
    }
    
    static func searchCharacters(by name: String) -> ApiEndpoint<CharacterResponseDTO> {
        .init(path: "character", method: .get, queryParameters: ["name": name])
    }
}
