//
//  BreweryImages.swift
//  BeersApp
//
//  Created by Marijan on 27/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

struct BreweryImages: DomainData {
    
    let id = ""
    let icon: String
    let large: String
    
    var uid: String {
        return self.id
    }
    
    init(icon: String, large: String) {
        self.icon = icon
        self.large = large
    }
    
    func asDatabaseType() -> RMBreweryImages {
        let images = RMBreweryImages()
        images.icon = self.icon
        images.large = self.large
        return images
    }
}
