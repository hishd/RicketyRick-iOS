//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-09.
//

import Foundation
import UIKit

final class MainViewController: UIViewController, Presentable {
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.textColor = .black
        label.font = .systemFont(ofSize: 32)
        return label
    }()
    
    var viewModel: (any ViewModel)?
    weak var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
    }
    
    func setConstraints() {
        view.backgroundColor = .white
        view.addSubview(textLabel)
        
        
        textLabel.center(inView: self.view)
        
//        textLabel.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
    }
    
    static func create(with viewModel: (any ViewModel)?) -> any Presentable {
        let viewController = MainViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
