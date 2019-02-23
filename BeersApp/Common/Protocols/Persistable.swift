//
//  Persistable.swift
//  ios learning
//
//  Created by UHP Digital Mac 3 on 04.02.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RealmSwift

protocol Persistable where Self: Object {
    
    associatedtype DomainType: DomainData
    
    func asDomain() -> DomainType
}

