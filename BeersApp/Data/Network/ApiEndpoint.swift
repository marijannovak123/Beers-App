//
//  ApiEndpoint.swift
//  ios learning
//
//  Created by Marijan on 26/01/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import Moya

enum ApiEndpoint {
    case beers(nameQuery: String)
    case breweries(nameQuery: String)
    case locations
}

extension ApiEndpoint: TargetType, AccessTokenAuthorizable {
    
    var authorizationType: AuthorizationType {
       return .bearer
    }
    
    var baseURL: URL { return URL(string: Config.baseUrl)! }
    
    var path: String {
        switch self {
        case .beers:
            return "beers"
        case .breweries:
            return "breweries"
        case .locations:
            return "locations"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .beers, .breweries, .locations:
            return .requestParameters(parameters: self.parameters, encoding: URLEncoding.default)
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .beers(let name), .breweries(let name):
            return ["key": Config.apiKey, "name": name, "p": 1]
        case .locations:
            return["key": Config.apiKey, "p": 1]
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
}
