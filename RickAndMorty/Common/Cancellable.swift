//
//  Cancellable.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

protocol Cancellable {
    var isNetworkTask: Bool {get set}
    var isSuccessful: Bool {get set}
    var isCancelled: Bool {get set}
    func cancel()
}

class CancellableTask: Cancellable {
    var isCancelled: Bool = false
    var isSuccessful: Bool = true
    var isNetworkTask: Bool = false
    var networkTask: CancellableHttpRequest?
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}

class CancellableTaskCollection: Cancellable {
    var isCancelled: Bool = false
    var isSuccessful: Bool = true
    var isNetworkTask: Bool = false
    var networkTasks: CancellableHttpRequestCollection?
    
    func cancel() {
        networkTasks?.cancelAll()
        isCancelled = true
    }
}
