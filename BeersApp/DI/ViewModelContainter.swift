//
//  ViewModelContainter.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Swinject

class ViewModelContainer {
    
    static func build(singletonContainer: Container) -> Container {
        let container = Container(parent: singletonContainer)
        
        container.register(BeerSearchVM.self) {
            BeerSearchVM(repository: $0.resolve(BeerRepository.self)!)
        }
        
        container.register(SavedBeersVM.self) {
            SavedBeersVM(repository: $0.resolve(BeerRepository.self)!)
        }
        return container
    }
}
