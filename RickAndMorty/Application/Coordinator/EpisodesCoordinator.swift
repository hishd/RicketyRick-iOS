//
//  EpisodesCoordinator.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation
import UIKit
import DependencyInjector

class EpisodesCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = []
    var viewController: EpisodesViewController?
    
    @Injectable(\.episodeRepository) var episodeRepository: EpisodeRepository
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = EpisodeViewModel(episodeRepository: episodeRepository)
        self.viewController = EpisodesViewController.create(with: viewModel)
        
        guard let viewController = self.viewController else {
            fatalError("View controller not instantiated")
        }
        
        let tabTitle = "Episodes"
        let defaultImage = UIImage(systemName: "tv")
        let tabBarItem = UITabBarItem(title: tabTitle, image: defaultImage, tag: 0)
        
        viewController.title = tabTitle
        viewController.tabBarItem = tabBarItem
        
        viewController.coordinator = self
        navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.delegate = self
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func scrollToTopItem() {
        viewController?.scrollToTopItem()
    }
}

extension EpisodesCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let sourceViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(sourceViewController) {
            return
        }

//        if let viewController = sourceViewController as? CharactersViewController {
//            childDidFinish(viewController.coordinator)
//        }
    }
}
