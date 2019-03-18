//
//  PersonalBeer.swift
//  BeersApp
//
//  Created by Marijan on 04/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxDataSources

struct PersonalBeer: DomainData {
    
    let id: String
    let name: String
    let description: String
    let abv: String
    let ibu: String
    let localImagePath: String?
    
    var uid: Any {
        return self.id
    }
    
    func asDatabaseType() -> RMPersonalBeer {
        let rmBeer = RMPersonalBeer()
        rmBeer.id = self.id
        rmBeer.name = self.name
        rmBeer.abv = self.abv
        rmBeer.ibu = self.ibu
        rmBeer.desc = self.description
        rmBeer.localImagePath = self.localImagePath
        return rmBeer
    }
   
}

extension PersonalBeer: IdentifiableType {
    
    var identity: String {
        return self.id
    }
    
}

struct PersonalBeerSection: Equatable {
    var beers: [PersonalBeer]
    var header: String?
    
    static func == (lhs: PersonalBeerSection, rhs: PersonalBeerSection) -> Bool {
        return lhs.beers == rhs.beers
    }
}

extension PersonalBeerSection: AnimatableSectionModelType {
    
    var items: [PersonalBeer] {
        return self.beers
    }
    
    init(original: PersonalBeerSection, items: [PersonalBeer]) {
        self = original
        self.beers = items
    }
    
    var identity: String? {
        return header
    }
    
}

