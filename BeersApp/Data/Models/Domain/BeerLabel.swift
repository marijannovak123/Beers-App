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
    let large: String
    
    init(icon: String, large: String) {
        self.icon = icon
        self.large = large
    }
    
    var uid: Any {
        return self.id
    }
    
    func asDatabaseType() -> RMBeerLabel {
        let localLabel = RMBeerLabel()
        localLabel.icon = self.icon
        localLabel.id = self.id
        localLabel.large = self.large
        return localLabel
    }
    
    typealias DatabaseType = RMBeerLabel
    
    
}
