//
//  EpisodeViewModel.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-08.
//

import Foundation

final class EpisodeViewModel: ViewModel {
    let paginationThreshold: Int = 5
    private let episodeRepository: EpisodeRepository
    private var dispatchWorkItem: DispatchWorkItem?
    var onSuccess: (() -> Void)?
    var onError: ((_ errorString: String) -> Void)?
    var onRefresh: (([IndexPath]) -> Void)?
    
    private var totalPages: Int = 0
    private var currentPage: Int = 0
    private var cancellableRequest: Cancellable?
    
    let wrappedEpisodes: ArrayWrapper<Episode> = .init(wrappedArray: .init())
    
    var searchText: String = .init()
    
    init(episodeRepository: EpisodeRepository) {
        self.episodeRepository = episodeRepository
    }
    
    func fetchData() {
        guard let onError = self.onError, let onSuccess = onSuccess else {
            fatalError("onSuccess and onError not implemented in view controller")
        }
        
        self.searchText = ""
        
        let fetchEpisodesUseCase: FetchEpisodesUseCase = .init(
            repository: self.episodeRepository,
            completionHandler: { [weak self] result in
                switch result {
                case .success(let page):
                    self?.currentPage = 1
                    self?.wrappedEpisodes.removeAll()
                    self?.wrappedEpisodes.append(contentsOf: page.episodes)
                    self?.totalPages = page.pages
                    onSuccess()
                case .failure(let error):
                    onError(
                        self?.decodeError(error: error) ?? error.localizedDescription
                    )
                }
            }
        )
        
        self.cancellableRequest = fetchEpisodesUseCase.execute()
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
    
    func loadMoreEpisodes() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            guard currentPage < totalPages else {
                return
            }
            
            //If the search text is empty, then execute the normal flow with pagination
            //Else execute the search flow with pagination
            if searchText.isEmpty {
                self.cancellableRequest = buildFetchEpisodesUseCaseWithPage(
                    page: self.currentPage + 1
                ).execute()
            } else {
                self.cancellableRequest = buildSearchEpisodeUseCaseWithPage(
                    name: searchText,
                    page: self.currentPage + 1
                ).execute()
            }
        }
    }
    
    func cancelAllOperations() {
        cancellableRequest?.cancel()
    }
    
    private func performSearch(for text: String) {
        guard let onError = self.onError, let onSuccess = onSuccess else {
            fatalError("onSuccess and onError not implemented in view controller")
        }
        
        self.currentPage = 1
        
        let searchEpisodesUseCase: SearchEpisodesUseCase = .init(
            repository: self.episodeRepository,
            name: text,
            completionHandler: {
                [weak self] result in
                switch result {
                case .success(let page):
                    self?.wrappedEpisodes.removeAll()
                    self?.wrappedEpisodes.append(contentsOf: page.episodes)
                    self?.totalPages = page.pages
                    onSuccess()
                case .failure(let error):
                    onError(
                        self?.decodeError(error: error) ?? error.localizedDescription
                    )
                }
            }
        )
        
        self.cancellableRequest = searchEpisodesUseCase.execute()
    }
    
    private func buildFetchEpisodesUseCaseWithPage(page: Int) -> FetchEpisodesUseCase {
        guard let onError = self.onError, let onRefresh = onRefresh else {
            fatalError("onSuccess and onRefresh not implemented in view controller")
        }
        
        return .init(
            repository: self.episodeRepository,
            page: page,
            completionHandler: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let page):
                    self.currentPage+=1
                    self.wrappedEpisodes.append(contentsOf: page.episodes)
                    self.totalPages = page.pages
                    
                    onRefresh(
                        self.buildIndexPaths(upTo: page.episodes.count)
                    )
                    
                case .failure(let error):
                    onError(
                        self.decodeError(error: error)
                    )
                }
            }
        )
    }
    
    private func buildIndexPaths(upTo newCount: Int) -> [IndexPath] {
        let from = self.wrappedEpisodes.content.count - newCount
        let to = self.wrappedEpisodes.content.count - 1
        let indexPaths: [IndexPath] = (from...to).map { index in
            return .init(row: index, section: 0)
        }
        
        return indexPaths
    }
    
    private func buildSearchEpisodeUseCaseWithPage(name: String, page: Int) -> SearchEpisodesUseCase {
        guard let onError = self.onError, let onRefresh = onRefresh else {
            fatalError("onSuccess and onRefresh not implemented in view controller")
        }
        
        return .init(
            repository: self.episodeRepository,
            page: page,
            name: name,
            completionHandler: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let page):
                    self.currentPage+=1
                    self.wrappedEpisodes.append(contentsOf: page.episodes)
                    self.totalPages = page.pages
                    
                    onRefresh(
                        self.buildIndexPaths(upTo: page.episodes.count)
                    )
                case .failure(let error):
                    onError(
                        self.decodeError(error: error)
                    )
                }
            }
        )
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
                error.isNotFoundError ? "Could not find the Episode" : "Unknown error occurred. Please try again later."
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
