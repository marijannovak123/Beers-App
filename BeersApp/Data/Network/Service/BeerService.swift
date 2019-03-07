//
//  BeerService.swift
//  BeersApp
//
//  Created by Marijan on 24/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxSwift

class BeerService: BaseService {
    
    func fetchBeersByName(query: String) -> Observable<[Beer]> {
        return api.request(target: .beers(nameQuery: query), responseType: BeersResponse.self)
            .map { $0.data ?? [] }
    }
}
