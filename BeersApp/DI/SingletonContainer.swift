//
//  SingletonContainer.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Swinject

class SingletonContainer {
    
    func build() -> Container {
        let container = Container(defaultObjectScope: .container)
        
        return container
    }
}
