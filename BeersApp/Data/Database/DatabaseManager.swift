//
//  DatabaseManager.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

class DatabaseManager {
    
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func allObjects<T: Persistable>() -> Observable<[T]> {
        let objects = realm.objects(T.self)
        return Observable.array(from: objects)
    }
    
    func objectsForValue<T: Persistable>(fieldName: String, fieldValue: CVarArg) -> Observable<[T]> {
        let predicate = NSPredicate(format: "\(fieldName) = %@", fieldValue)
        let objects = realm.objects(T.self).filter(predicate)
        return Observable.array(from: objects)
    }
    
    func singleObject<T: Persistable>(id: Int) -> Observable<T> {
        let object = realm.object(ofType: T.self, forPrimaryKey: id)
        return Observable.from(object: object ?? T.init())
    }
    
}
