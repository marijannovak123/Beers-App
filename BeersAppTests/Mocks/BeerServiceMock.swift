//
//  BeerServiceMock.swift
//  BeersAppTests
//
//  Created by UHP Mac on 16/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
@testable import BeersApp
import RxSwift

class BeerServiceMock: BaseMock, BeerService {
    
    func fetchBeersByName(query: String) -> Observable<[Beer]> {
        return generateRxResult(ModelMocks.beers)
    }
    
}
