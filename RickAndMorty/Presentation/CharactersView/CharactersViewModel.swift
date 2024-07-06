//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation

class CharactersViewModel: ViewModel {
    
    private var dispatchWorkItem: DispatchWorkItem?
    
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
    
    func fetchData() {
        
    }
    
    private func performSearch(for text: String) {
        
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
