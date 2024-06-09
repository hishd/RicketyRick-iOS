//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-09.
//

import Foundation
import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.textColor = .black
        label.font = .systemFont(ofSize: 32)
        return label
    }()
    
    private var viewModel: MainViewViewModel!
    private var coordinator: Coordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(textLabel)
        
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    static func create(with viewModel: MainViewViewModel, coordinator: Coordinator) -> MainViewController {
        let viewController = MainViewController()
        viewController.coordinator = coordinator
        viewController.viewModel = viewModel
        return viewController
    }
}
