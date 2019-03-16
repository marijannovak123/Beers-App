//
//  SingletonContainer.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Swinject
import RealmSwift
import Moya

class SingletonContainer {
    
    static func build() -> Container {
        let container = Container(defaultObjectScope: .container)
        
        // MARK: Singletons
        container.register(Realm.self) { _ in
            if let realm = try? Realm() {
                return realm
            } else {
                fatalError("realm creation error")
            }
        }
        
        container.register(DatabaseManager.self) {
            DatabaseManager(realm: $0.resolve(Realm.self)!)
        }
        
        container.register(MoyaProvider<ApiEndpoint>.self) {
            //mock using JWT for learning purposes
            let userDefaults = $0.resolve(UserDefaultsHelper.self)!
            let authPlugin = AccessTokenPlugin(tokenClosure: { userDefaults.getJwt() })
            return MoyaProvider<ApiEndpoint>(plugins: [authPlugin])
        }
        
        container.register(ApiNetwork.self) {
            ApiNetwork(provider: $0.resolve(MoyaProvider<ApiEndpoint>.self)!)
        }
        
        container.register(UserDefaultsHelper.self) { _ in
            UserDefaultsHelper()
        }
        
        
        // MARK: Services
        container.register(BeerService.self) {
            BeerServiceImpl(api: $0.resolve(ApiNetwork.self)!)
        }
        
        container.register(BreweryService.self) {
            BreweryService(api: $0.resolve(ApiNetwork.self)!)
        }
        
        container.register(LocationService.self) {
            LocationService(api: $0.resolve(ApiNetwork.self)!)
        }
        
        // MARK: Storages
        container.register(BeerStorage.self) {
            BeerStorageImpl(dbManager: $0.resolve(DatabaseManager.self)!)
        }
        
        container.register(BreweryStorage.self) {
            BreweryStorage(dbManager: $0.resolve(DatabaseManager.self)!)
        }
        
        container.register(LocationStorage.self) {
            LocationStorage(dbManager: $0.resolve(DatabaseManager.self)!)
        }
        
        // MARK: Repositories
        container.register(BeerRepository.self) {
            BeerRepositoryImpl(service: $0.resolve(BeerService.self)!, storage: $0.resolve(BeerStorage.self)!)
        }
        
        container.register(BreweryRepository.self) {
            BreweryRepositoryImpl(service: $0.resolve(BreweryService.self)!, storage: $0.resolve(BreweryStorage.self)!)
        }
        
        container.register(LocationRepository.self) {
            LocationRepositoryImpl(service: $0.resolve(LocationService.self)!, storage: $0.resolve(LocationStorage.self)!)
        }
        return container
    }
}
