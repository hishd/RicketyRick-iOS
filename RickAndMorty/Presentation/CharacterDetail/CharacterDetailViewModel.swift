//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-16.
//

import Foundation

final class CharacterDetailViewModel: ViewModel {
    let character: Character
    let episodeRepository: EpisodeRepository
    var episodeData: ArrayWrapper<Episode> = .init(wrappedArray: .init())
    var cancellableRequest: (any Cancellable)?
    
    var onSuccess: (() -> Void)?
    var onError: ((_ errorString: String) -> Void)?
    
    init(character: Character, episodeRepository: EpisodeRepository) {
        self.character = character
        self.episodeRepository = episodeRepository
    }
    
    func loadEpisodeData() {
        
        guard let onError = self.onError, let onSuccess = self.onSuccess else {
            fatalError("onError and onSuccess not implemented in view controller")
        }
        
        printIfDebug("====Loading Episode Data====")
        
        let unwrappedUrls = self.character.episodes.compactMap{return $0}
        
        let getEpisodeByUrlsUseCase: GetEpisodesByUrlsUseCase = .init(
            repository: self.episodeRepository,
            urls: unwrappedUrls) { result in
                switch result {
                case .success(let episodes):
                    self.episodeData.content = episodes
                    onSuccess()
                case .failure(_):
                    onError("Could not load episode data. Please retry!")
                }
            }
        
        self.cancellableRequest = getEpisodeByUrlsUseCase.execute()
    }
    
    func cancelAllOperations() {
        self.cancellableRequest?.cancel()
    }
}
