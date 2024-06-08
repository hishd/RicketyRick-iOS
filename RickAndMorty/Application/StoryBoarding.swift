//
//  StoryBoarding.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-09.
//

import Foundation
import UIKit

protocol StoryBoarding {
    static func instantiate() -> Self
}

extension StoryBoarding where Self : UIViewController {
    static func instantiate() -> Self {
        let fileName = NSStringFromClass(self)
        let storyBoardClassName = fileName.components(separatedBy: ".")[1]
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: storyBoardClassName) as! Self
    }
}
