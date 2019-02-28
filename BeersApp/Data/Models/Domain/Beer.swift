//
//  Beer.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxDataSources

struct Beer: DomainData {
   
    let id: String
    let name: String
    let description: String?
    let abv: String?
    let ibu: String?
    let style: BeerStyle?
    let labels: BeerLabel?
    
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
        beer.labels = self.labels?.asDatabaseType()
        return beer
    }
    
}

struct BeerWrapper: IdentifiableType, Equatable {
    let beer: Beer
    let isExpanded: Bool
    let index: Int
    
    var identity: String {
        return self.beer.id
    }
    
    static func == (lhs: BeerWrapper, rhs: BeerWrapper) -> Bool {
        return (lhs.beer.id == rhs.beer.id && lhs.isExpanded == rhs.isExpanded)
    }
}

struct BeerSection {
    var beers: [BeerWrapper]
    var header: String?
}

extension BeerSection: AnimatableSectionModelType {
    
    var items: [BeerWrapper] {
        return self.beers
    }
    
    init(original: BeerSection, items: [BeerWrapper]) {
        self = original
        self.beers = items
    }
    
    var identity: String? {
        return header
    }
    
}
