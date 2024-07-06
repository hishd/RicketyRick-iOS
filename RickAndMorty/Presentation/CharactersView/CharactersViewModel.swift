//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation

class CharactersViewModel: ViewModel {
    
    let characterRepository: CharacterRepository
    var fetchCharactersUseCase: FetchCharactersUseCase?
    private var dispatchWorkItem: DispatchWorkItem?
    var onSuccess: (() -> Void)?
    var onError: ((_ errorString: String) -> Void)?
    
    var characters: [Character] = .init()
    var totalPages: Int = 0
    var currentPage: Int = 0
    var cancellableRequest: Cancellable?
    
    init(characterRepository: CharacterRepository) {
        self.characterRepository = characterRepository
    }
    
    func fetchData() {
        guard let onError = self.onError, let onSuccess = onSuccess else {
            fatalError("onSuccess and onError not implemented in view controller")
        }
        
        self.fetchCharactersUseCase = .init(
            repository: self.characterRepository,
            completionHandler: { [weak self] result in
                switch result {
                case .success(let page):
                    self?.characters.removeAll()
                    self?.characters.append(contentsOf: page.characters)
                    self?.totalPages = page.pages
                    onSuccess()
                case .failure(let error):
                    onError(error.localizedDescription)
                }
            }
        )
        
        self.cancellableRequest = fetchCharactersUseCase?.execute()
    }
    
    private func performSearch(for text: String) {
        guard let onError = self.onError, let onSuccess = onSuccess else {
            fatalError("onSuccess and onError not implemented in view controller")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            onError("Failed to load characters")
        }
    }
    
    func searchData(searchText: String) {
        dispatchWorkItem?.cancel()
        
        guard !searchText.isEmpty else {
            return
        }
        
        dispatchWorkItem = DispatchWorkItem { [weak self] in
            print("Fetching data for text \(searchText)")
            self?.performSearch(for: searchText)
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.75, execute: dispatchWorkItem!)
    }
    
    func cancelAllOperations() {
        
    }
}
