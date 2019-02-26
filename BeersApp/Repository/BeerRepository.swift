//
//  BeerRepository.swift
//  BeersApp
//
//  Created by Marijan on 24/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxSwift

class BeerRepository {
    
    private let service: BeerService
    private let storage: BeerStorage
    
    init(service: BeerService, storage: BeerStorage) {
        self.service = service
        self.storage = storage
    }
    
    func fetchBeers(query: String) -> Observable<[Beer]> {
        return service.fetchBeersByName(query: query)
    }
    
    func saveBeer(_ beer: Beer) -> Observable<Void> {
        return storage.save(beer)
    }
    
    func loadPersistedBeers() -> Observable<[Beer]> {
        return storage.loadAllBeers()
    }
    
    func deleteBeer(_ beer: Beer) -> Observable<Void> {
        return storage.deleteBeer(beer)
    }
    
}
