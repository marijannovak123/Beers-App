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

class BeerRepositoryMock: BeerRepository {
    
    var shouldFail = false
    
    func fetchBeers(query: String) -> Observable<[Beer]> {
        return Observable.just(ModelMocks.beers)
    }
    
    func saveBeer(_ beer: Beer) -> Observable<Void> {
        return Observable.just(())
    }
    
    func loadPersistedBeers() -> Observable<[Beer]> {
        return Observable.just(ModelMocks.beers)
    }
    
    func deleteBeer(_ beer: Beer) -> Observable<Void> {
        return Observable.just(())
    }
    
    func deleteAllBeers() -> Observable<Void> {
        return Observable.just(())
    }
    
}
