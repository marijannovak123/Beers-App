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
}

extension ApiEndpoint: TargetType {
    
    var baseURL: URL { return URL(string: Config.baseUrl)! }
    
    var path: String {
        switch self {
        case .beers:
            return "beers"
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
        case .beers:
            return .requestParameters(
                parameters: self.parameters,
                encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .beers(let name):
            return ["key": Config.apiKey, "name": name, "p": 1]
        default:
            return ["key": Config.apiKey]
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
}
