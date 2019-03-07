//
//  RMLocation.swift
//  BeersApp
//
//  Created by Marijan on 06/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

class RMLocation: BaseModel, Persistable {
    
    @objc var name = ""
    @objc var streetAddress = ""
    @objc var locality = ""
    @objc var region: String?
    @objc var postalCode = ""
    @objc var latitude: Double = 0.0
    @objc var longitude: Double = 0.0
    @objc var brewery: RMBrewery?
    @objc var countryIsoCode = ""
    
    func asDomain() -> Location {
        return Location(
            id: self.id,
            name: self.name,
            streetAddress: self.streetAddress,
            locality: self.locality,
            region: self.region,
            postalCode: self.postalCode,
            latitude: self.latitude,
            longitude: self.longitude,
            brewery: self.brewery?.asDomain(),
            countryIsoCode: self.countryIsoCode
        )
    }
    
}
