//
//  UIViewController+Extensions.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-09-17.
//

import Foundation
import UIKit

extension UIViewController {
    func embed(_ viewController:UIViewController, activate constraints: [NSLayoutConstraint]){
        viewController.willMove(toParent: self)
        self.addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
        viewController.didMove(toParent: self)
    }
}
