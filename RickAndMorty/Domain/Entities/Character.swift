//
//  Character.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

enum CharacterStatus {
    case alive
    case dead
    case unknown
}

struct CharacterOrigin {
    let originName: String
    let locationUrl: URL?
}

struct CharacterLastLocation {
    let locationName: String
    let locationUrl: URL?
}

struct Character {
    let characterId: Int
    let characterName: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOrigin
    let lastLocation: CharacterLastLocation
    let imageUrl: URL?
    let episodes: [URL?]
    let createdData: Date?
    
    #if DEBUG
    static let sample: Character = .init(
        characterId: 0,
        characterName: "Rick Sanchez",
        status: .alive,
        species: "Human",
        type: "",
        gender: "Male",
        origin: .init(originName: "Earth (C-137)", locationUrl: .init(string: "https://rickandmortyapi.com/api/location/1")),
        lastLocation: .init(locationName: "Citadel of Ricks", locationUrl: .init(string: "https://rickandmortyapi.com/api/location/3")),
        imageUrl: .init(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
        episodes: [
            .init(string: "https://rickandmortyapi.com/api/episode/1"),
            .init(string: "https://rickandmortyapi.com/api/episode/2"),
            .init(string: "https://rickandmortyapi.com/api/episode/3"),
            .init(string: "https://rickandmortyapi.com/api/episode/4"),
            .init(string: "https://rickandmortyapi.com/api/episode/5"),
        ],
        createdData: .init()
    )
    #endif
}

struct CharacterPage {
    let count: Int
    let pages: Int
    let characters: [Character]
}
