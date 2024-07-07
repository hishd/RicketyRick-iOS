//
//  LocationsCoordinator.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation
import UIKit

class LocationsCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = UIViewController()
        
        let tabTitle = "Locations"
        let defaultImage = UIImage(systemName: "globe.europe.africa")
        let tabBarItem = UITabBarItem(title: tabTitle, image: defaultImage, tag: 0)
        
        viewController.title = tabTitle
        viewController.tabBarItem = tabBarItem
        
//        viewController.coordinator = self
        navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.delegate = self
        self.navigationController.pushViewController(viewController, animated: false)
    }
}

extension LocationsCoordinator: UINavigationControllerDelegate {
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
