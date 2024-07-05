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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charactersCoordinator.start()
        
        self.viewControllers = [
            charactersCoordinator.navigationController
        ]
    }
}
