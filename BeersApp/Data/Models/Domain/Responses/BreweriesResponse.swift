//
//  BreweriesResponse.swift
//  BeersApp
//
//  Created by Marijan on 01/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

struct BreweriesResponse: Decodable {
    let totalResults: Int?
    let currentPage: Int?
    let status: String
    let numberOfPages: Int?
    let data: [Brewery]?
}

