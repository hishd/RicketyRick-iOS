//
//  UIViewController+Extensions.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-09-17.
//

import Foundation
import UIKit

extension UIViewController {
    func embed(_ viewController:UIViewController, with setConstraints: () -> Void){
        viewController.willMove(toParent: self)
        view.addSubview(viewController.view)
        self.addChild(viewController)
        setConstraints()
        viewController.didMove(toParent: self)
    }
}
