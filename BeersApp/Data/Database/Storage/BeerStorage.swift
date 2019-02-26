//
//  BeerStorage.swift
//  BeersApp
//
//  Created by Marijan on 24/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxSwift

class BeerStorage: BaseStorage {
    
    func save(_ beer: Beer) -> Observable<Void> {
        return databaseManager.saveObject(object: beer)
    }
    
    func loadAllBeers() -> Observable<[Beer]> {
        return databaseManager.allObjects(oftype: Beer.self)
    }
}
