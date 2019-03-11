//
//  LocationRepository.swift
//  BeersApp
//
//  Created by Marijan on 06/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxSwift

protocol LocationRepository {
    
    func fetchLocations() -> Observable<[Location]>
    
}

class LocationRepositoryImpl: LocationRepository {
    
    private let service: LocationService
    private let storage: LocationStorage
    
    init(service: LocationService, storage: LocationStorage) {
        self.service = service
        self.storage = storage
    }
    
    func fetchLocations() -> Observable<[Location]> {
        return service.fetchLocations()
    }
}
