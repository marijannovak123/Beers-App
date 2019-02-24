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
    
    init(service: BeerService) {
        self.service = service
    }
    
    func fetchBeers(query: String) -> Observable<[Beer]> {
        return service.fetchBeersByName(query: query)
    }
    
}
