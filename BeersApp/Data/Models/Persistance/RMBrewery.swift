//
//  RMBrewery.swift
//  BeersApp
//
//  Created by Marijan on 27/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

class RMBrewery: BaseModel, Persistable {
    
    @objc dynamic var name = ""
    @objc dynamic var desc = ""
    @objc dynamic var website = ""
    @objc dynamic var established = 0
    @objc dynamic var images: RMBreweryImages?
    
    func asDomain() -> Brewery {
        return Brewery(id: "")
    }

}
