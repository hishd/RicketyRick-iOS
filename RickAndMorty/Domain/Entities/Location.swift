//
//  Location.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-06-11.
//

import Foundation

struct LocationResident {
    let characterUrl: URL
}

struct Location {
    let locationId: String
    let locationName: String
    let locationType: String
    let dimension: String
    let residents: [LocationResident]
    let createdData: Date
}

struct LocationPage {
    let count: Int
    let pages: Int
    let locations: [Location]
}
