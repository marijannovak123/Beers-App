//
//  RMBreweryImages.swift
//  BeersApp
//
//  Created by Marijan on 27/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

class RMBreweryImages: BaseModel, Persistable {
    
    @objc dynamic var icon = ""
    @objc dynamic var large = ""
    
    func asDomain() -> BreweryImages {
        return BreweryImages(icon: self.icon, large: self.large)
    }
}
