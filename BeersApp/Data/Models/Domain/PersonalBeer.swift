//
//  PersonalBeer.swift
//  BeersApp
//
//  Created by Marijan on 04/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

struct PersonalBeer {
   
    let id: String
    let name: String
    let description: String
    let abv: String
    let ibu: String
    
    
    func asBeer() -> Beer {
        return Beer(id: self.id, name: self.name, description: self.description, abv: self.abv, ibu: self.ibu, style: nil, labels: nil)
    }
}
