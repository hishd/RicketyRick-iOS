//
//  LocationEndpoints.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

enum LocationEndpoints {
    static func allLocations(from page: Int?) -> ApiEndpoint<LocationResponseDTO> {
        var params: [String: Int] = [:]
        if let page = page {
            params["page"] = page
        }
        
        return .init(path: "location", method: .get, queryParameters: params)
    }
    
    static func searchLocations(by name: String, from page: Int?) -> ApiEndpoint<LocationResponseDTO> {
        var params: [String: Any] = [:]
        params["name"] = name
        
        if let page = page {
            params["page"] = page
        }
        
        return .init(path: "location", method: .get, queryParameters: params)
    }
}
