//
//  BreweryRepository.swift
//  BeersApp
//
//  Created by Marijan on 27/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import RxSwift

class BreweryRepository {
    
    private let service: BreweryService
    private let storage: BreweryStorage
    
    init(service: BreweryService, storage: BreweryStorage) {
        self.service = service
        self.storage = storage
    }
    
    func getBreweriesByName(name: String) -> Observable<[Brewery]> {
        return service.fetchBreweriesByName(name: name)
    }
}
