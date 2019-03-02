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
    @objc dynamic var desc: String?
    @objc dynamic var isOrganic = false
    @objc dynamic var website: String?
    @objc dynamic var established: String?
    @objc dynamic var images: RMBreweryImages?
    
    func asDomain() -> Brewery {
        return Brewery(
            id: self.id,
            name: self.name,
            isOrganic: self.isOrganic ? "Y" : "N",
            established: self.established,
            description: self.desc,
            website: self.website,
            images: self.images?.asDomain()
        )
    }

}
