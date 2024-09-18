//
//  EpisodeDetailViewModel.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-09-18.
//

import Foundation

final class EpisodeDetailViewModel: ViewModel {
    let episode: Episode

    private let characterRepository: CharacterRepository
    let wrappedCharacters: ArrayWrapper<Character> = .init(wrappedArray: .init())
    
    var onSuccess: (() -> Void)?
    var onError: ((_ errorString: String) -> Void)?
    private var cancellableRequest: Cancellable?
    
    init(episode: Episode, characterRepository: CharacterRepository) {
        self.episode = episode
        self.characterRepository = characterRepository
    }
    
    func loadCharacterData() {
        guard let onError = self.onError, let onSuccess = onSuccess else {
            fatalError("onSuccess and onError not implemented in view controller")
        }
        
        let unwrappedCharacterUrls: [URL] = episode.characters.compactMap { $0.characterUrl }
        
        let fetchCharactersByUrlUseCase: GetCharactersByUrlsUseCase = .init(
            repository: characterRepository,
            urls: unwrappedCharacterUrls) { result in
                switch result {
                case .success(let characters):
                    self.wrappedCharacters.content = characters
                    onSuccess()
                case .failure(_):
                    onError("Could not character data. Please Retry!")
                }
            }
        
        self.cancellableRequest = fetchCharactersByUrlUseCase.execute()
    }
    
    func cancelAllOperations() {
        self.cancellableRequest?.cancel()
    }
}
