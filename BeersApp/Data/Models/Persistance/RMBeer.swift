//
//  RMBeer.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RealmSwift

class RMBeer: Object, Persistable {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var desc = ""
    @objc dynamic var abv = ""
    @objc dynamic var ibu = ""
    @objc dynamic var style: RMBeerStyle?
    
    func asDomain() -> Beer {
        return Beer (
            id: self.id,
            name: self.name,
            description: self.desc,
            abv: self.abv,
            ibu: self.ibu,
            style: self.style?.asDomain()
        )
    }
    
}
