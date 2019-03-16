//
//  BeerService.swift
//  BeersApp
//
//  Created by Marijan on 24/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxSwift

protocol BeerService {
    func fetchBeersByName(query: String) -> Observable<[Beer]>
}

class BeerServiceImpl: BaseService, BeerService {
    
    func fetchBeersByName(query: String) -> Observable<[Beer]> {
        return apiListRequest(target: .beers(nameQuery: query), responseType: ApiResult<Beer>.self)
    }
}
