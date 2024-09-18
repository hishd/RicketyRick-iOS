//
//  EpisodeDetailViewModel.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-09-18.
//

import Foundation

final class EpisodeDetailViewModel: ViewModel {
    let episode: Episode
    
    init(with episode: Episode) {
        self.episode = episode
    }
    
    func cancelAllOperations() {
        
    }
}
