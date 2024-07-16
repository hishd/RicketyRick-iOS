//
//  CharacterDetailCoordinator.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-16.
//

import Foundation
import UIKit

class CharacterDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = .init()
    var character: Character?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let character = character else {
            fatalError("Character not initialised.......!")
        }
        
        let viewModel = CharacterDetailViewModel(character: character)
        let viewController = CharacterDetailViewController.create(with: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
