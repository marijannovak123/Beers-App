//
//  BeerRepositoryMock.swift
//  BeersAppTests
//
//  Created by Marijan on 11/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxSwift
@testable import BeersApp

class BeerRepositoryMock: BaseMock, BeerRepository {
    
    func fetchBeers(query: String) -> Observable<[Beer]> {
        return generateRxResult(ModelMocks.beers)
    }
    
    func saveBeer(_ beer: Beer) -> Observable<Void> {
        return generateRxResult(())
    }
    
    func loadPersistedBeers() -> Observable<[Beer]> {
        return generateRxResult(ModelMocks.beers)
    }
    
    func deleteBeer(_ beer: Beer) -> Observable<Void> {
        return generateRxResult(())
    }
    
    func deleteAllBeers() -> Observable<Void> {
        return generateRxResult(())
    }
    
}
