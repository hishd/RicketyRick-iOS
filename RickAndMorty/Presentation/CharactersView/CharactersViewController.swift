//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation
import UIKit

class CharactersViewController: UIViewController, Presentable {
    var viewModel: (any ViewModel)?
    var coordinator: CharactersCoordinator?
    
    static func create(with viewModel: (any ViewModel)?) -> CharactersViewController {
        let viewController = CharactersViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func setConstraints() {
        
    }
}
