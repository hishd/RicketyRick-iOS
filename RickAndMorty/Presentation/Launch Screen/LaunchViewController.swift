//
//  LaunchViewController.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-04.
//

import Foundation
import UIKit

class LaunchViewController: UIViewController {
    
    lazy var titleImage: UIImageView = {
        let imageView = UIImageView(image: .imgTitle)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var portalImage: UIImageView = {
        let imageView = UIImageView(image: .imgPortal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var rickImage: UIImageView = {
        let imageView = UIImageView(image: .imgRick)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var mortyImage: UIImageView = {
        let imageView = UIImageView(image: .imgMorty)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
