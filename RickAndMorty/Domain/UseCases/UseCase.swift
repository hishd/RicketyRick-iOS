//
//  UseCase.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

protocol UseCase {
    func execute() -> CancellableHttpRequest?
}
