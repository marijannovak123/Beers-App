//
//  BeerLabel.swift
//  BeersApp
//
//  Created by Marijan on 26/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

struct BeerLabel: DomainData {
    
    let id: String = ""
    let icon: String
    
    init(icon: String) {
        self.icon = icon
    }
    
    var uid: Any {
        return self.id
    }
    
    func asDatabaseType() -> RMBeerLabel {
        let localLabel = RMBeerLabel()
        localLabel.icon = self.icon
        localLabel.id = self.id
        return localLabel
    }
    
    typealias DatabaseType = RMBeerLabel
    
    
}
