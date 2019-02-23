//
//  BeerCategory.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

struct BeerCategory: DomainData {
    
    let id: Int
    let name: String
    
    var uid: Any {
        return self.id
    }
    
    func asDatabaseType() -> RMBeerCategory {
        let beerCategory = RMBeerCategory()
        beerCategory.id = self.id
        beerCategory.name = self.name
        return beerCategory
    }
}
