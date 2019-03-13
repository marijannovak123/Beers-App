//
//  File.swift
//  BeersApp
//
//  Created by Marijan on 24/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

class ApiResult<T>: Decodable where T: DomainData {
    let totalResults: Int?
    let currentPage: Int?
    let status: String
    let numberOfPages: Int?
    let data: [T]?
}
