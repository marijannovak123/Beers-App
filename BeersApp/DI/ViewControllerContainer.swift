//
//  ViewControllerContainer.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Swinject

class ViewControllerContainer {
    
    func build(viewModelContainer: Container) -> Container {
        let container = Container(parent: viewModelContainer)
        
        return container
    }
}
