//
//  CharactersCoordinator.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation
import UIKit
import DependencyInjector

class CharactersCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = []
    var viewController: CharactersViewController?
    
    @Injectable(\.characterRepository) var characterRepository: CharacterRepository
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CharactersViewModel(characterRepository: self.characterRepository)
        self.viewController = CharactersViewController.create(with: viewModel)
        
        guard let viewController = self.viewController else {
            fatalError("View controller not instantiated")
        }
        
        let tabTitle = "Characters"
        let defaultImage = UIImage(systemName: "person.text.rectangle")
        let tabBarItem = UITabBarItem(title: tabTitle, image: defaultImage, tag: 0)
        
        viewController.title = tabTitle
        viewController.tabBarItem = tabBarItem
        
        viewController.coordinator = self
        navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.delegate = self
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func launchDetailFlow(for character: Character) {
        let detailCoordinator = CharacterDetailCoordinator(navigationController: self.navigationController)
        detailCoordinator.character = character
        self.childCoordinators.append(detailCoordinator)
        detailCoordinator.start()
    }
    
    func scrollToTopItem() {
        viewController?.scrollToTopItem()
    }
}

extension CharactersCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let sourceViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(sourceViewController) {
            return
        }

        if let viewController = sourceViewController as? CharactersViewController {
            childDidFinish(viewController.coordinator)
        }
        
        if let viewController = sourceViewController as? CharacterDetailViewController {
            childDidFinish(viewController.coordinator)
        }
    }
}
