//
//  UIResult.swift
//  BeersApp
//
//  Created by Marijan on 26/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

enum UIResult { //refactor to enum
    case error(_ message: String)
    case success(_ message: String?)
}
