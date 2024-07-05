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
        
        let tabTitle = "Characters"
        let defaultImage = UIImage(named: "person.text.rectangle")
        let tabBarItem = UITabBarItem(title: tabTitle, image: defaultImage, tag: 0)
        
        viewController.title = tabTitle
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }
    
    func setConstraints() {
        
    }
}
