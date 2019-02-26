//
//  RMBeer.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RealmSwift

class RMBeer: BaseModel, Persistable {
    
    @objc dynamic var name = ""
    @objc dynamic var desc: String?
    @objc dynamic var abv: String?
    @objc dynamic var ibu: String?
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


