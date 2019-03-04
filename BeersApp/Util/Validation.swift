//
//  Validator.swift
//  Autism Helper iOS
//
//  Created by UHP Digital Mac 3 on 11.02.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

enum ValidationType {
    case notEmpty
    case isEmail
    case requiredLength(_ length: Int)
    case isProperDate
    
    func resolveFailedValidationMessage() -> String {
        switch self {
        case .notEmpty:
            return "input_required".localized
        case .isEmail:
            return "malformed_mail".localized
        case .requiredLength(let length):
            return String(format: "input_length".localized, length)
        case .isProperDate:
            return "incorrect_date".localized
        }
    }
}

enum InputType {
    case regularText
    case email
    case password
    case username
    case date
    
    var validationTypes: [ValidationType] {
        switch self {
        case .regularText:
            return [.notEmpty]
        case .email:
            return [.notEmpty, .isEmail]
        case .password:
            return [.notEmpty, .requiredLength(3)]
        case .username:
            return [.notEmpty, .requiredLength(4)]
        case .date:
            return [.notEmpty, .isProperDate]
        }
    }
}

