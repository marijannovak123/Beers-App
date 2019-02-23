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
    case beers(pageNo: Int)
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
        return .requestPlain
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .beers(let pageNo):
            return ["p": pageNo, "key": Config.apiKey]
        default:
            return ["key": Config.apiKey]
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
}
