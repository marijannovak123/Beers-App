//
//  UserDefaultsHelper.swift
//  Autism Helper iOS
//
//  Created by UHP Digital Mac 3 on 11.02.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

class UserDefaultsHelper {
    
    func setUserLoggedIn(_ isLoggedIn: Bool) {
        UserDefaults.standard.set(isLoggedIn, forKey: Constants.isLoggedIn)
    }
    
    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.isLoggedIn)
    }
}
