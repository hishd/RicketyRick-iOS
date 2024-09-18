//
//  EpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-09-18.
//

import Foundation
import UIKit

final class EpisodeDetailViewController: UIViewController, Presentable {
    var viewModel: EpisodeDetailViewModel?
    var coordinator: EpisodeDetailCoordinator?
    
    private lazy var mainView = EpisodeDetailView(episode: viewModel?.episode)
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConstraints()
        self.setEpisodeData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.cancelAllOperations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData()
    }
    
    static func create(with viewModel: EpisodeDetailViewModel?) -> EpisodeDetailViewController {
        let viewController = EpisodeDetailViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func setConstraints() {
        view.backgroundColor = .systemBackground
    }
}

extension EpisodeDetailViewController {
    private func setEpisodeData() {
        guard let episode = viewModel?.episode else {
            let alert = UIAlertController(title: "Operation Error", message: "Could not find Episode Information", preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
            return
        }
        
        self.title = episode.episodeName
        self.mainView.progressIndicator.startAnimating()
    }
    
    private func loadData() {
        
    }
}
