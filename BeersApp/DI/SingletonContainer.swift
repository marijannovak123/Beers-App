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
    
    func build() -> Container {
        let container = Container(defaultObjectScope: .container)
        
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
        
        container.register(MoyaProvider<ApiEndpoint>.self) { _ in
            MoyaProvider<ApiEndpoint>()
        }
        
        container.register(ApiNetwork.self) {
            ApiNetwork(provider: $0.resolve(MoyaProvider<ApiEndpoint>.self)!)
        }
        
        container.register(UserDefaultsHelper.self) { _ in
            UserDefaultsHelper()
        }
        
        return container
    }
}
