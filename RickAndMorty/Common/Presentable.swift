//
//  Presentable.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-05.
//

import Foundation
import UIKit

protocol Presentable: UIViewController {
    
    var viewModel: ViewModel? {get set}
    var coordinator: Coordinator? {get set}
    
    func setConstraints()
    static func create(with viewModel: ViewModel?) -> Presentable
}
