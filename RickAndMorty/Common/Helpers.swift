//
//  Helpers.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

func mapStringsToUrl(urlStrings: [String]) -> [URL?] {
    return urlStrings.map { item in
            return .init(string: item)
    }
}
