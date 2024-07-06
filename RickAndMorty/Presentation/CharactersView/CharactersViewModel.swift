//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation

class CharactersViewModel: ViewModel {
    var characters: [Character] = {
        Array(0...10).map { number in
            return Character.init(
                characterId: number,
                characterName: "Character \(number)",
                status: number.isMultiple(of: 2) ? CharacterStatus.alive : .dead,
                species: "Species \(number)",
                type: "Type \(number)",
                gender: number.isMultiple(of: 2) ? "Male" : "Female",
                origin: .init(originName: "Origin \(number)", locationUrl: nil),
                lastLocation: .init(locationName: "Origin \(number)", locationUrl: nil),
                imageUrl: nil,
                episodes: .init(),
                createdData: nil
            )
        }
    }()
    
    func fetchCharacters() {
        
    }
}
