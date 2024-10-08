//
//  CharacterDetailCoordinator.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-16.
//

import Foundation
import UIKit
import DependencyInjector

class CharacterDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = .init()
    var character: Character?
    
    @Injectable(\.episodeRepository) var episodeRepository: EpisodeRepository
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
//        #warning("Remove after testing....!!!!")
//        self.character = Character.sample
        
        guard let character = character else {
            fatalError("Character not initialised.......!")
        }
        
        let viewModel = CharacterDetailViewModel(character: character, episodeRepository: episodeRepository)
        let viewController = CharacterDetailViewController.create(with: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
