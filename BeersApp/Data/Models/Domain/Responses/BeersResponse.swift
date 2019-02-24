//
//  File.swift
//  BeersApp
//
//  Created by Marijan on 24/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

struct BeersResponse: Codable {
    let totalResults: Int?
    let currentPage: Int?
    let status: String
    let numberOfPages: Int?
    let data: [Beer]?
}
