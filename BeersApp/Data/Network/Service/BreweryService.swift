//
//  BreweryService.swift
//  BeersApp
//
//  Created by Marijan on 27/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import RxSwift

class BreweryService: BaseService {

    func fetchBreweriesByName(name: String) -> Observable<[Brewery]> {
        return api.request(target: .breweries(nameQuery: name), responseType: BreweriesResponse.self)
            .map { $0.data ?? [] }
    }
}
