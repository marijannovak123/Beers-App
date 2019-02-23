//
//  BeerStyle.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

struct BeerStyle: DomainData{
    
    let id: Int
    let categoryId: Int
    let category: BeerCategory?
    let name: String
    let description: String
    let ibuMin: String
    let ibuMax: String
    let abvMin: String
    let abvMax: String
    
    var uid: Any {
        return self.id
    }
    
    func asDatabaseType() -> RMBeerStyle {
        let style = RMBeerStyle()
        
        style.id = self.id
        style.categoryId = self.categoryId
        style.category = self.category?.asDatabaseType()
        style.name = self.name
        style.desc = self.description
        style.ibuMin = self.ibuMin
        style.ibuMax = self.ibuMax
        style.abvMin = self.abvMin
        style.abvMax = self.abvMax
        
        return style
    }
}
