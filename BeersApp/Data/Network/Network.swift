//
//  Network.swift
//  ios learning
//
//  Created by UHP Digital Mac 3 on 28.01.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Moya
import RxSwift

typealias CompletionHandler = () -> Void
typealias NetworkErrorHandler = (NetworkError) -> Void
typealias NetworkResult<T> = Result<T, NetworkError>


enum Result<T, ErrorType: Error> {
    case success(T)
    case failure(ErrorType)
}


struct NetworkError: Error {
    let status: ResponseStatus
    let errorMessage: String
    
    init(error: MoyaError?) {
        if let response = error?.response {
            let decodedStatus = ResponseStatus.getByCode(code: response.statusCode)
            if decodedStatus == .parseError {
                status = .parseError
            } else {
                status = decodedStatus
            }
        } else {
            status = .unrecognized
        }
        errorMessage = status.errorDescription
    }
}

// Standard status codes (add any that are missing and are used in app)
enum ResponseStatus: Int {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case notAcceptable = 406
    case notAllowed = 409
    case teapot = 418
    case unprocessableEntity = 422
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case unrecognized = -1
    case appIncompatible = -2
    case parseError = -3
    
    var errorDescription: String {
        switch self {
        case .unauthorized:
            return "Not authorized."
        case .internalServerError:
            return "Internal Server error."
        case .serviceUnavailable:
            return "Server is down."
        default:
            return String(describing: self)
        }
    }
    
    static func getByCode(code: Int) -> ResponseStatus {
        switch code {
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 406:
            return .notAcceptable
        case 409:
            return .notAllowed
        case 418:
            return .teapot
        case 422:
            return .unprocessableEntity
        case 500:
            return .internalServerError
        case 501:
            return .notImplemented
        case 502:
            return .badGateway
        case 503:
            return .serviceUnavailable
        case 200:
            return .parseError
        default:
            return .unrecognized
        }
    }
}

class Network<ApiTarget: TargetType> {
    
    private var provider: MoyaProvider<ApiTarget>
    
    init(provider: MoyaProvider<ApiTarget>) {
        self.provider = provider
    }
    
    func request<T: Decodable>(target: ApiTarget, responseType: T.Type) -> Observable<T> {
        return provider.rx.request(target)
            .asObservable()
            .filterSuccessfulStatusCodes()
            .map(responseType)
    }
}

class ApiNetwork: Network<ApiEndpoint> {}

