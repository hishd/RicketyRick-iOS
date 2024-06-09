//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-09.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController {get set}
    var childCoordinators: [Coordinator] {get set}
    
    func start()
}
