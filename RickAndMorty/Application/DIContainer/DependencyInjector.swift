//
//  DependencyContainer.swift
//  RickAndMorty
//
//  Created by Hishara Dilshan on 2024-07-06.
//

import Foundation
import DependencyInjector

fileprivate var networkConfig: ApiNetworkConfig = {
    let url = URL(string: ApplicationConstants.apiBaseUrl)
    return .init(baseUrl: url!)
}()

fileprivate var networkService: NetworkService = {
    return DefaultNetworkService.init(networkConfig: networkConfig, sessionManagerType: .defaultType, loggerType: .defaultType)
}()

fileprivate var dataTransferService: NetworkDataTransferService = {
    return DefaultNetworkDataTransferService.init(networkService: networkService, logger: DefaultNetworkDataTransferErrorLogger())
}()


fileprivate class CharacterRepositoryRemoteDependency: InjectableDependency {
    static var dependency: CharacterRepository = CharacterRepositoryRemote(networkDataTransferService: dataTransferService)
}

extension InjectableValues {
    var characterRepository: CharacterRepository {
        get {
            Self[CharacterRepositoryRemoteDependency.self]
        }
        set {
            Self[CharacterRepositoryRemoteDependency.self] = newValue
        }
    }
}
