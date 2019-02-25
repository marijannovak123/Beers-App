//
//  RMBeerStyle.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RealmSwift

class RMBeerStyle: Object, Persistable {
    
    @objc dynamic var id = 0
    @objc dynamic var categoryId = 0
    @objc dynamic var category: RMBeerCategory?
    @objc dynamic var name = ""
    @objc dynamic var desc: String?
    @objc dynamic var ibuMin: String?
    @objc dynamic var ibuMax: String?
    @objc dynamic var abvMin: String?
    @objc dynamic var abvMax: String?
    
    func asDomain() -> BeerStyle {
        return BeerStyle(
            id: self.id,
            categoryId: self.categoryId,
            category: self.category?.asDomain(),
            name: self.name,
            description: self.desc,
            ibuMin: self.ibuMin,
            ibuMax: self.ibuMax,
            abvMin: self.abvMin,
            abvMax: self.abvMax
        )
    }
    
}
