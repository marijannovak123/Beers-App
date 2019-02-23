//
//  Beer.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

struct Beer: DomainData {
    
    let id: String
    let name: String
    let description: String
    let abv: String
    let ibu: String
    let style: BeerStyle?
    
    var uid: Any {
        return self.id
    }
    
    func asDatabaseType() -> RMBeer {
        let beer = RMBeer()
        beer.id = self.id
        beer.name = self.name
        beer.desc = self.description
        beer.abv = self.abv
        beer.ibu = self.ibu
        beer.style = self.style?.asDatabaseType()
        return beer
    }
    
}
