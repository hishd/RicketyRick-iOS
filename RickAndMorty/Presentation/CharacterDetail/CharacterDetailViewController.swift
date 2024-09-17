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
    private lazy var mainView = CharacterDetailView(character: viewModel?.character)
    private lazy var episodeInformationController = EpisodeInformationViewController(
        episodeData: self.viewModel?.episodeData ?? .init()
    )
    
    override func loadView() {
        self.view = mainView
    }
    
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
        mainView.setConstraints()
        
        self.embed(episodeInformationController, activate: [
            episodeInformationController.view.leadingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            episodeInformationController.view.trailingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            episodeInformationController.view.topAnchor.constraint(equalTo: mainView.characterInformationView.bottomAnchor, constant: 10),
            episodeInformationController.view.bottomAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.bottomAnchor)
        ])
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
