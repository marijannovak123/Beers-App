//
//  BeerStorageMock.swift
//  BeersAppTests
//
//  Created by UHP Mac on 16/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
@testable import BeersApp
import RxSwift

class BeerStorageMock: BaseMock, BeerStorage {
    
    func save(_ beer: Beer) -> Observable<Void> {
        return generateRxResult(())
    }
    
    func loadAllBeers() -> Observable<[Beer]> {
        return generateRxResult(ModelMocks.beers)
    }
    
    func deleteBeer(_ beer: Beer) -> Observable<Void> {
        return generateRxResult(())
    }
    
    func deleteAllBeers() -> Observable<Void> {
        return generateRxResult(())
    }
    
}
