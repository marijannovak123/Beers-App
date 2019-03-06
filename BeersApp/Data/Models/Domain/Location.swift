//
//  Location.swift
//  BeersApp
//
//  Created by Marijan on 06/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

struct Location: DomainData {
    
    let id: String
    let name: String
    let streetAddress: String
    let locality: String
    let region: String
    let postalCode: String
    let latitude: Double
    let longitude: Double
    let brewery: Brewery?
    let countryIsoCode: String
    
    var uid: Any {
        return self.id
    }
    
    func asDatabaseType() -> RMLocation {
        let rmLocation = RMLocation()
        rmLocation.id = self.id
        rmLocation.name = self.name
        rmLocation.streetAddress = self.streetAddress
        rmLocation.locality = self.locality
        rmLocation.region = self.region
        rmLocation.postalCode = self.postalCode
        rmLocation.latitude = self.latitude
        rmLocation.longitude = self.longitude
        rmLocation.brewery = self.brewery?.asDatabaseType()
        rmLocation.countryIsoCode = self.countryIsoCode
        return rmLocation
    }
    
}
