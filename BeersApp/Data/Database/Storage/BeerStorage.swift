//
//  BeerStorage.swift
//  BeersApp
//
//  Created by Marijan on 24/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxSwift

protocol BeerStorage {
    func save(_ beer: Beer) -> Observable<Void>
    
    func savePersonal(_ beer: PersonalBeer) -> Observable<Void>
    
    func loadAllBeers() -> Observable<[Beer]>
    
    func loadAllPersonalBeers() -> Observable<[PersonalBeer]>
    
    func deleteBeer(_ beer: Beer) -> Observable<Void>
    
    func deleteAllBeers() -> Observable<Void>
}

class BeerStorageImpl: BaseStorage, BeerStorage {
    
    func savePersonal(_ beer: PersonalBeer) -> Observable<Void> {
        return databaseManager.saveObject(object: beer)
    }
    
    func save(_ beer: Beer) -> Observable<Void> {
        return databaseManager.saveObject(object: beer)
    }
    
    func loadAllBeers() -> Observable<[Beer]> {
        return databaseManager.allObjects(oftype: Beer.self)
    }
    
    func loadAllPersonalBeers() -> Observable<[PersonalBeer]> {
        return databaseManager.allObjects(oftype: PersonalBeer.self)
    }
    
    func deleteBeer(_ beer: Beer) -> Observable<Void> {
        return databaseManager.deleteObject(object: beer)
    }
    
    func deleteAllBeers() -> Observable<Void> {
        return Observable.zip(
                databaseManager.deleteAll(type: Beer.self),
                databaseManager.deleteAll(type: PersonalBeer.self)
            ).mapToVoid()
    }
}
