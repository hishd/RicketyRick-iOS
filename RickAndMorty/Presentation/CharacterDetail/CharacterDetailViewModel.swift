//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-16.
//

import Foundation

final class CharacterDetailViewModel: ViewModel {
    let character: Character
    let episodeData: [Episode] = (0...10).map { _ in
        Episode.sample
    }
    
    init(character: Character) {
        self.character = character
    }
    
    func loadEpisodeData() {
        
    }
}
