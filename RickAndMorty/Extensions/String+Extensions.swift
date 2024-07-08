//
//  String+Extensions.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-08.
//

import Foundation

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

//Usage Example
//let str = "Hello, playground"
//print(str.substring(from: 7))         // playground
//print(str.substring(to: 5))           // Hello
//print(str.substring(with: 7..<11))    // play
