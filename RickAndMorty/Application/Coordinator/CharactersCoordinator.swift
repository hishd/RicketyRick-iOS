//
//  CharactersCoordinator.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation
import UIKit

class CharactersCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CharactersViewModel()
        let viewController = CharactersViewController.create(with: viewModel)
        viewController.coordinator = self
        self.navigationController.delegate = self
        self.navigationController.pushViewController(viewController, animated: false)
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
    }
}
