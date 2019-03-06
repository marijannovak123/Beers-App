//
//  LocationsResponse.swift
//  BeersApp
//
//  Created by Marijan on 06/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

struct LocationsResponse: Decodable {
    let totalResults: Int?
    let currentPage: Int?
    let status: String
    let numberOfPages: Int?
    let data: [Location]?
}
