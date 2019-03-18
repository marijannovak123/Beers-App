//
//  RMPersonalBeer.swift
//  BeersApp
//
//  Created by UHP Mac on 18/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

class RMPersonalBeer: BaseModel, Persistable {
    
    @objc dynamic var name = ""
    @objc dynamic var desc = ""
    @objc dynamic var abv = ""
    @objc dynamic var ibu = ""
    @objc dynamic var localImagePath: String?
    
    func asDomain() -> PersonalBeer {
        return PersonalBeer(
            id: self.id,
            name: self.name,
            description: self.desc,
            abv: self.abv,
            ibu: self.ibu,
            localImagePath: self.localImagePath
        )
    }
    
}
