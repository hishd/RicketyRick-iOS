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
    
    private var totalPages: Int = 0
    private var currentPage: Int = 0
    private var cancellableRequest: Cancellable?
    
    let wrappedCharacters: ArrayWrapper<Character> = .init(wrappedArray: .init())
    
    var searchText: String = .init()
    
    init(characterRepository: CharacterRepository) {
        self.characterRepository = characterRepository
    }
    
    func fetchData() {
        guard let onError = self.onError, let onSuccess = onSuccess else {
            fatalError("onSuccess and onError not implemented in view controller")
        }
        
        self.searchText = ""
        
        let fetchCharactersUseCase: FetchCharactersUseCase = .init(
            repository: self.characterRepository,
            completionHandler: { [weak self] result in
                switch result {
                case .success(let page):
                    self?.currentPage = 1
                    self?.wrappedCharacters.removeAll()
                    self?.wrappedCharacters.append(contentsOf: page.characters)
                    self?.totalPages = page.pages
                    onSuccess()
                case .failure(let error):
                    onError(
                        self?.decodeError(error: error) ?? error.localizedDescription
                    )
                }
            }
        )
        
        self.cancellableRequest = fetchCharactersUseCase.execute()
    }
    
    func searchData() {
        dispatchWorkItem?.cancel()
        
        guard !searchText.isEmpty else {
            self.fetchData()
            return
        }
        
        dispatchWorkItem = DispatchWorkItem { [weak self] in
            guard let searchText = self?.searchText else {
                return
            }
            print("Fetching data for text \(searchText)")
            self?.performSearch(for: searchText)
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.75, execute: dispatchWorkItem!)
    }
    
    func loadMoreCharacters() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            guard currentPage < totalPages else {
                return
            }
            
            //If the search text is empty, then execute the normal flow with pagination
            //Else execute the search flow with pagination
            if searchText.isEmpty {
                self.cancellableRequest = buildFetchCharacterUseCaseWithPage(
                    page: self.currentPage + 1
                ).execute()
            } else {
                self.cancellableRequest = buildSearchCharacterUseCaseWithPage(
                    name: searchText,
                    page: self.currentPage + 1
                ).execute()
            }
        }
    }
    
    private func performSearch(for text: String) {
        guard let onError = self.onError, let onSuccess = onSuccess else {
            fatalError("onSuccess and onError not implemented in view controller")
        }
        
        self.currentPage = 1
        
        let searchCharactersUseCase: SearchCharactersUseCase = .init(
            repository: self.characterRepository,
            name: text,
            completionHandler: {
                [weak self] result in
                switch result {
                case .success(let page):
                    self?.wrappedCharacters.removeAll()
                    self?.wrappedCharacters.append(contentsOf: page.characters)
                    self?.totalPages = page.pages
                    onSuccess()
                case .failure(let error):
                    onError(
                        self?.decodeError(error: error) ?? error.localizedDescription
                    )
                }
            }
        )
        
        self.cancellableRequest = searchCharactersUseCase.execute()
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
                    self?.wrappedCharacters.append(contentsOf: page.characters)
                    self?.totalPages = page.pages
                    onSuccess()
                case .failure(let error):
                    onError(
                        self?.decodeError(error: error) ?? error.localizedDescription
                    )
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
                    self?.wrappedCharacters.append(contentsOf: page.characters)
                    self?.totalPages = page.pages
                    onSuccess()
                case .failure(let error):
                    onError(
                        self?.decodeError(error: error) ?? error.localizedDescription
                    )
                }
            }
        )
    }
    
    func cancelAllOperations() {
        cancellableRequest?.cancel()
    }
    
    private func decodeError(error: Error) -> String {
        print(error)
        
        guard let dataTransferError = error as? NetworkDataTransferError else {
            return "Unknown error occurred"
        }
        
        return switch dataTransferError {
        case .noResponse:
            "No results found. Please try again later."
        case .parsing(_):
            "Could not display results. Please try again later."
        case .networkFailure(let networkError):
            decodeNetworkError(error: networkError)
        case .resolvedNetworkFailure(_):
            "Network error occurred. Please try again later."
        }
        
        func decodeNetworkError(error: NetworkError) -> String {
            return switch error {
            case .error(_, _):
                error.isNotFoundError ? "Could not find the character" : "Unknown error occurred. Please try again later."
            case .notConnected:
                "Connection error. Please try again later."
            case .cancelled:
                "Operation is cancelled."
            case .generic(_):
                "Unknown error occurred. Please try again later."
            case .urlGeneration:
                "Invalid request url found."
            }
        }
    }
}

//extension
