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
    let locationUrl: URL
}

struct CharacterLastLocation {
    let locationName: String
    let locationUrl: String
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
    let imageUrl: URL
    let episodes: [URL]
    let createdData: Date
}

struct CharacterPage {
    let count: Int
    let pages: Int
    let characters: [Character]
}
