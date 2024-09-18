//
//  LocationDetailCoordinator.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-09-18.
//

import Foundation
import UIKit
import DependencyInjector

final class LocationDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    let location: Location
    var childCoordinators: [any Coordinator] = .init()
    
    @Injectable(\.locationRepository) var locationRepository: LocationRepository
    
    init(navigationController: UINavigationController, location: Location) {
        self.navigationController = navigationController
        self.location = location
    }
    
    func start() {
        let viewModel = LocationDetailViewModel(location: location, locationRepository: locationRepository)
        let viewController = LocationDetailViewController.create(with: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
