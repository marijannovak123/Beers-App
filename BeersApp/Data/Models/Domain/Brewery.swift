//
//  Brewery.swift
//  BeersApp
//
//  Created by Marijan on 27/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

struct Brewery: DomainData {
    
    let id: String
    
    var uid: Any {
        return self.id
    }
    
    func asDatabaseType() -> RMBrewery {
        return RMBrewery()
    }

}
