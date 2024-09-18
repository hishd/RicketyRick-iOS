//
//  EpisodeDetailCoordinator.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-09-18.
//

import Foundation
import UIKit

final class EpisodeDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    let episode: Episode
    var childCoordinators: [any Coordinator] = .init()
    
    init(navigationController: UINavigationController, episode: Episode) {
        self.navigationController = navigationController
        self.episode = episode
    }
    
    func start() {
        let viewModel = EpisodeDetailViewModel(with: episode)
        let viewController = EpisodeDetailViewController.create(with: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
