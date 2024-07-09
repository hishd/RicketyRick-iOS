//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-09.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let charactersCoordinator: CharactersCoordinator = CharactersCoordinator(navigationController: UINavigationController())
    let episodesCoordinator: EpisodesCoordinator = EpisodesCoordinator(navigationController: UINavigationController())
    let locationsCoordinator: LocationsCoordinator = LocationsCoordinator(navigationController: UINavigationController())
    
    var lastSelectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        charactersCoordinator.start()
        episodesCoordinator.start()
        locationsCoordinator.start()
        
        self.viewControllers = [
            charactersCoordinator.navigationController,
            episodesCoordinator.navigationController,
            locationsCoordinator.navigationController
        ]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        
        if index == self.lastSelectedIndex {
            switch index {
            case 0:
                charactersCoordinator.scrollToTopItem()
            case 1:
                episodesCoordinator.scrollToTopItem()
            case 2:
                locationsCoordinator.scrollToTopItem()
            default:
                break;
            }
        }

        self.lastSelectedIndex = index
    }
}
