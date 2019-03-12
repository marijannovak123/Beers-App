//
//  LocationService.swift
//  BeersApp
//
//  Created by Marijan on 06/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxSwift

class LocationService: BaseService {
    
    func fetchLocations() -> Observable<[Location]> {
        return api.request(target: .locations, responseType: LocationsResponse.self)
            .map { $0.data ?? [] }
            .catchErrorJustReturn([])
    }
}

