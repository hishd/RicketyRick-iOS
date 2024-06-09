//
//  RootCoordinator.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-09.
//

import Foundation
import UIKit

class RootCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [any Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MainViewViewModel()
        let viewController = MainViewController.create(with: viewModel, coordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
}
