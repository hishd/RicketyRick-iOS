//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-09.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {
    
    let charactersCoordinator: Coordinator = CharactersCoordinator(navigationController: UINavigationController())
    let episodesCoordinator: Coordinator = EpisodesCoordinator(navigationController: UINavigationController())
    let locationsCoordinator: Coordinator = LocationsCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charactersCoordinator.start()
        episodesCoordinator.start()
        locationsCoordinator.start()
        
//        let viewController = UIViewController()
//        
//        let tabTitle = "Locations"
//        let defaultImage = UIImage(systemName: "globe.europe.africa")
//        let tabBarItem = UITabBarItem(title: tabTitle, image: defaultImage, tag: 0)
//        
//        viewController.title = tabTitle
//        viewController.tabBarItem = tabBarItem
        
        self.viewControllers = [
            charactersCoordinator.navigationController,
            episodesCoordinator.navigationController,
            locationsCoordinator.navigationController
        ]
    }
}
