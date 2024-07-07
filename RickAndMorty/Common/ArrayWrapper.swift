//
//  ArrayWrapper.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-07.
//

import Foundation

class ArrayWrapper<T> {
    var content: [T]
    var isEmpty: Bool {
        self.content.isEmpty
    }
    
    init(wrappedArray: [T]) {
        self.content = wrappedArray
    }
    
    subscript(index: Int) -> T {
        get {
            return content[index]
        }
        
        set(newValue) {
            content[index] = newValue
        }
    }
    
    func removeAll() {
        self.content.removeAll()
    }
    
    func append(contentsOf content: [T]) {
        self.content.append(contentsOf: content)
    }
}
