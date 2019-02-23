//
//  RMBeerCategory.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RealmSwift

class RMBeerCategory: Object, Persistable {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    func asDomain() -> BeerCategory {
        return BeerCategory(id: self.id, name: self.name)
    }
    
}
