//
//  Brewery.swift
//  BeersApp
//
//  Created by Marijan on 27/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxDataSources

struct Brewery: DomainData {
    
    let id: String
    let name: String
    let isOrganic: String?
    let established: String?
    let description: String?
    let website: String?
    let images: BreweryImages?
    
    var uid: Any {
        return self.id
    }
    
    func asDatabaseType() -> RMBrewery {
        let rmBrewery = RMBrewery()
        rmBrewery.id = self.id
        rmBrewery.name = self.name
        rmBrewery.isOrganic = self.isOrganic == "Y"
        rmBrewery.website = self.website
        rmBrewery.images = self.images?.asDatabaseType()
        return rmBrewery
    }

}

extension Brewery: IdentifiableType, Equatable {
    
    var identity: String {
        return self.id
    }
    
    static func == (lhs: Brewery, rhs: Brewery) -> Bool {
        return lhs.id == rhs.id
    }
    
}

struct BrewerySection {
    var breweries: [Brewery]
    var header: String?
}

extension BrewerySection: AnimatableSectionModelType {

    var identity: String? {
        return header
    }
    
    var items: [Brewery] {
        return self.breweries
    }

    init(original: BrewerySection, items: [Brewery]) {
        self = original
        self.breweries = items
    }
}
