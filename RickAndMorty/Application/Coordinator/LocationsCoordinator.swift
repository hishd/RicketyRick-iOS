//
//  LocationsCoordinator.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation
import UIKit
import DependencyInjector

class LocationsCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = []
    var viewController: LocationsViewController?
    
    @Injectable(\.locationRepository) private var locationRepository: LocationRepository
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = LocationsViewModel(locationRepository: locationRepository)
        self.viewController = LocationsViewController.create(with: viewModel)
        
        guard let viewController = self.viewController else {
            fatalError("View controller not instantiated")
        }
        
        let tabTitle = "Locations"
        let defaultImage = UIImage(systemName: "globe.europe.africa")
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
    
    func launchDetailFlow(for location: Location) {
        let detailCoordinator = LocationDetailCoordinator(navigationController: self.navigationController, location: location)
        self.childCoordinators.append(detailCoordinator)
        detailCoordinator.start()
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
