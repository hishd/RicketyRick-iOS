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
        self.setCharacterData()
    }
    
    static func create(with viewModel: CharacterDetailViewModel?) -> CharacterDetailViewController {
        let viewController = CharacterDetailViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func setConstraints() {
        view.backgroundColor = .systemBackground
    }
    
    func setCharacterData() {
        guard let character = viewModel?.character else {
            let errorAlert = UIAlertController(title: "Operation Error", message: "Could not find character information", preferredStyle: .alert)
            errorAlert.addAction(.init(title: "Ok", style: .cancel))
            self.present(errorAlert, animated: true)
            return
        }
        
        self.title = character.characterName
    }
}
