//
//  MockLocationRepository.swift
//  RickAndMortyTests
//
//  Created by Hishara Dilshan on 2024-06-12.
//

import Foundation
@testable import RickAndMorty

enum MockLocationRepositoryError: Error {
    case notFound
}

final class MockLocationRepository: LocationRepository {
    
    private var url: URL? {
        let bundle = Bundle(for: MockLocationRepository.self)
        return bundle.url(forResource: "locations", withExtension: "json")
    }
    
    private var locationData: LocationPage? {
        guard let url = self.url else {
            fatalError("Could not generate url for locations")
        }
        
        let data = try? Data(contentsOf: url)
        
        if let data = data {
            let content = try? JSONDecoder().decode(LocationResponseDTO.self, from: data)
            return content?.mapToDomain()
        }
        
        return nil
    }
    
    func fetchLocation(by id: Int, completion: @escaping CompletionHandler) -> (any RickAndMorty.Cancellable)? {
        let filteredLocation = self.locationData?.locations.first { $0.locationId == id }
        let handler: (Result<Location, Error>)
        
        defer {
            completion(handler)
        }
        
        if let location = filteredLocation {
            handler = .success(location)
        } else {
            handler = .failure(MockLocationRepositoryError.notFound)
        }
        
        return nil
    }
    
    func fetchLocations(from page: Int?, completion: @escaping CompletionHandlerPage) -> (any RickAndMorty.Cancellable)? {
        let handler: (Result<LocationPage, Error>)
        
        defer {
            completion(handler)
        }
        
        if let page = locationData {
            handler = .success(page)
        } else {
            handler = .failure(MockLocationRepositoryError.notFound)
        }
        
        return nil
    }
    
    func searchLocations(by name: String, from page: Int?, completion: @escaping CompletionHandlerPage) -> (any RickAndMorty.Cancellable)? {
        let filteredLocations = self.locationData?.locations.filter {
            $0.locationName == name
        }
        let handler: (Result<LocationPage, Error>)
        
        defer {
            completion(handler)
        }
        
        if let locations = filteredLocations {
            let page = LocationPage(count: locationData!.count, pages: locationData!.pages, locations: locations)
            handler = .success(page)
        } else {
            handler = .failure(MockLocationRepositoryError.notFound)
        }
        
        return nil
    }
}
