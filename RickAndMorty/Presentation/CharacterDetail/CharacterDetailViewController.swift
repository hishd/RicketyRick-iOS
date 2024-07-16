//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-16.
//

import Foundation
import UIKit

final class CharacterDetailViewController: UIViewController, Presentable {
    
    var viewModel: CharacterDetailViewModel?
    var coordinator: CharacterDetailCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConstraints()
    }
    
    static func create(with viewModel: CharacterDetailViewModel?) -> CharacterDetailViewController {
        let viewController = CharacterDetailViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func setConstraints() {
        
    }
}
