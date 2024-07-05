//
//  Presentable.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation
import UIKit

protocol Presentable: UIViewController where AnyCoordinator: Coordinator, AnyViewController: UIViewController {
    
    associatedtype AnyCoordinator
    associatedtype AnyViewController
    
    var viewModel: ViewModel? {get set}
    var coordinator: AnyCoordinator? {get set}
    
    static func create(with viewModel: ViewModel?) -> AnyViewController
    func setConstraints()
}
