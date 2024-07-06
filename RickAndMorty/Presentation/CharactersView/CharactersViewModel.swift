//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation

final class CharactersViewModel: ViewModel {
    let paginationThreshold: Int = 5
    private let characterRepository: CharacterRepository
    private var dispatchWorkItem: DispatchWorkItem?
    var onSuccess: (() -> Void)?
    var onError: ((_ errorString: String) -> Void)?
    
    var characters: [Character] = .init()
    private var totalPages: Int = 0
    private var currentPage: Int = 0
    private var cancellableRequest: Cancellable?
    
    init(characterRepository: CharacterRepository) {
        self.characterRepository = characterRepository
    }
    
    func fetchData() {
        guard let onError = self.onError, let onSuccess = onSuccess else {
            fatalError("onSuccess and onError not implemented in view controller")
        }
        
        let fetchCharactersUseCase: FetchCharactersUseCase = .init(
            repository: self.characterRepository,
            completionHandler: { [weak self] result in
                switch result {
                case .success(let page):
                    self?.currentPage = 1
                    self?.characters.removeAll()
                    self?.characters.append(contentsOf: page.characters)
                    self?.totalPages = page.pages
                    onSuccess()
                case .failure(let error):
                    onError(error.localizedDescription)
                }
            }
        )
        
        self.cancellableRequest = fetchCharactersUseCase.execute()
    }
    
    func searchData(searchText: String) {
        dispatchWorkItem?.cancel()
        
        guard !searchText.isEmpty else {
            self.fetchData()
            return
        }
        
        dispatchWorkItem = DispatchWorkItem { [weak self] in
            print("Fetching data for text \(searchText)")
            self?.performSearch(for: searchText)
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.75, execute: dispatchWorkItem!)
    }
    
    func loadMoreCharacters() {
        guard currentPage < totalPages else {
            return
        }
                
        self.cancellableRequest = buildFetchCharacterUseCaseWithPage(
            page: self.currentPage + 1
        ).execute()
    }
    
    private func performSearch(for text: String) {
        guard let onError = self.onError, let onSuccess = onSuccess else {
            fatalError("onSuccess and onError not implemented in view controller")
        }
        
        self.currentPage = 1
        
    }
    
    private func buildFetchCharacterUseCaseWithPage(page: Int) -> FetchCharactersUseCase {
        guard let onError = self.onError, let onSuccess = onSuccess else {
            fatalError("onSuccess and onError not implemented in view controller")
        }
        
        return .init(
            repository: self.characterRepository,
            page: page,
            completionHandler: { [weak self] result in
                switch result {
                case .success(let page):
                    self?.currentPage+=1
                    self?.characters.append(contentsOf: page.characters)
                    self?.totalPages = page.pages
                    onSuccess()
                case .failure(let error):
                    onError(error.localizedDescription)
                }
            }
        )
    }
    
    private func buildSearchCharacterUseCaseWithPage(name: String, page: Int) -> SearchCharactersUseCase {
        guard let onError = self.onError, let onSuccess = onSuccess else {
            fatalError("onSuccess and onError not implemented in view controller")
        }
        
        return .init(
            repository: self.characterRepository,
            page: page,
            name: name,
            completionHandler: {
                [weak self] result in
                switch result {
                case .success(let page):
                    self?.currentPage+=1
                    self?.characters.append(contentsOf: page.characters)
                    self?.totalPages = page.pages
                    onSuccess()
                case .failure(let error):
                    onError(error.localizedDescription)
                }
            }
        )
    }
    
    func cancelAllOperations() {
        cancellableRequest?.cancel()
    }
}
