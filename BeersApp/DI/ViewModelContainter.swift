//
//  ViewModelContainter.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Swinject

class ViewModelContainer {
    
    func build(singletonContainer: Container) -> Container {
        let container = Container(parent: singletonContainer)
        
        return container
    }
}
