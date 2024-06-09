//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-09.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController {get set}
    var childCoordinators: [Coordinator] {get set}
    
    func start()
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        for (index, element) in childCoordinators.enumerated() {
            if element === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
