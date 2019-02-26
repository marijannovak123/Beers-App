//
//  RMBeerCategory.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RealmSwift

class RMBeerCategory: BaseModel, Persistable {
    
    @objc dynamic var name = ""
    
    func asDomain() -> BeerCategory {
        return BeerCategory(id: Int(self.id)!, name: self.name)
    }
    
}
