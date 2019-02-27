//
//  RMBrewery.swift
//  BeersApp
//
//  Created by Marijan on 27/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

class RMBrewery: BaseModel, Persistable {
    
    func asDomain() -> Brewery {
        return Brewery(id: "")
    }

}
