//
//  RMBeerLabel.swift
//  BeersApp
//
//  Created by Marijan on 26/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

class RMBeerLabel: BaseModel, Persistable {
    
    @objc dynamic var icon = ""
    
    func asDomain() -> BeerLabel {
        return BeerLabel(icon: self.icon)
    }
    
}
