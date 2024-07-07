//
//  Presentable.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation
import UIKit

protocol Presentable: UIViewController where AnyCoordinator: Coordinator, AnyViewController: UIViewController, AnyViewModel: ViewModel {
    
    associatedtype AnyCoordinator
    associatedtype AnyViewController
    associatedtype AnyViewModel
    
    var viewModel: AnyViewModel? {get set}
    var coordinator: AnyCoordinator? {get set}
    
    static func create(with viewModel: AnyViewModel?) -> AnyViewController
    func setConstraints()
}
