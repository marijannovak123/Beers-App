//
//  ModelMocks.swift
//  BeersAppTests
//
//  Created by Marijan on 11/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
@testable import BeersApp

class ModelMocks {
    
    private init() {}
    
    static var beers: [Beer] {
        return [
            Beer(id: "one1", name: "First Beer", description: "Beer no 1", abv: nil, ibu: nil, style: nil, labels: nil),
            Beer(id: "two2", name: "Second Beer", description: "Beer no 2", abv: nil, ibu: nil, style: nil, labels: nil)
        ]
    }
    
    static var beerWrappers: [BeerWrapper] {
        return [
            BeerWrapper(beer: beers[0], isExpanded: false, index: 0),
            BeerWrapper(beer: beers[1], isExpanded: false, index: 1)
        ]
    }
    
    static var expandedAtFirstIndexBeerWrappers: [BeerWrapper] {
        return [
            BeerWrapper(beer: beers[0], isExpanded: true, index: 0),
            BeerWrapper(beer: beers[1], isExpanded: false, index: 1)
        ]
    }
    
    static var beerSections: [BeerSection] {
        return [BeerSection(beers: beerWrappers, header: nil)]
    }
    
    static var beerSectionsWithExpandedFirstElement: [BeerSection] {
        return [BeerSection(beers: expandedAtFirstIndexBeerWrappers, header: nil)]
    }
}
