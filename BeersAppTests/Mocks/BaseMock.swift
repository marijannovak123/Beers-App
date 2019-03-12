//
//  BaseMock.swift
//  BeersAppTests
//
//  Created by Marijan on 12/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxSwift

struct MockError: Error {
    let message: String
}

class BaseMock {
    
    var shouldFail = false
    
    var error: Error {
        return MockError(message: "mocked error")
    }
    
    func generateResult<T>(_ resultIfNotFail: T) -> Observable<T> {
        if shouldFail {
            return Observable.error(error)
        } else {
            return Observable.just(resultIfNotFail)
        }
    }

}
