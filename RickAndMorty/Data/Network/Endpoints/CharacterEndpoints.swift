//
//  CharacterEndpoints.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

enum CharacterEndpoints {
    static func getCharacter(by id: Int) -> ApiEndpoint<CharacterResponseDTO.ResultsDTO> {
        return .init(path: .path("character/\(id)"), method: .get)
    }
    
    static func allCharacters(from page: Int?) -> ApiEndpoint<CharacterResponseDTO> {
        var params: [String: Int] = [:]
        if let page = page {
            params["page"] = page
        }
        
        return .init(path: .path("character"), method: .get, queryParameters: params)
    }
    
    static func searchCharacters(by name: String, from page: Int?) -> ApiEndpoint<CharacterResponseDTO> {
        var params: [String: Any] = [:]
        params["name"] = name
        
        if let page = page {
            params["page"] = page
        }
        
        return .init(path: .path("character"), method: .get, queryParameters: params)
    }
}
