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
    
    func loadAllBeers() -> Observable<[Beer]>
    
    func deleteBeer(_ beer: Beer) -> Observable<Void>
    
    func deleteAllBeers() -> Observable<Void>
}

class BeerStorageImpl: BaseStorage, BeerStorage {
    
    func save(_ beer: Beer) -> Observable<Void> {
        return databaseManager.saveObject(object: beer)
    }
    
    func loadAllBeers() -> Observable<[Beer]> {
        return databaseManager.allObjects(oftype: Beer.self)
    }
    
    func deleteBeer(_ beer: Beer) -> Observable<Void> {
        return databaseManager.deleteObject(object: beer)
    }
    
    func deleteAllBeers() -> Observable<Void> {
        return databaseManager.deleteAll(type: Beer.self)
    }
}
