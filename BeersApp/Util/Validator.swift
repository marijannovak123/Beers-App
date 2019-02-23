//
//  Validator.swift
//  Autism Helper iOS
//
//  Created by UHP Digital Mac 3 on 11.02.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

typealias FormDictionary = [String: FormInput]

protocol InputErrorDelegate: class {
    func setFailedValidation(_ failedValidation: ValidationType)
    func setValidState(_ name: String?)
}

enum ValidationType {
    case notEmpty
    case isEmail
    case requiredLength(_ length: Int)
    case isProperDate
    case isGender
    
    func resolveFailedValidationMessage() -> String {
        switch self {
        case .notEmpty:
            return "Input is required"
        case .isEmail:
            return "Malformed email"
        case .requiredLength(let length):
            return "Input should be at least \(length) characters long"
        case .isProperDate:
            return "Incorrect date formatting"
        case .isGender:
            return "Not a gender"
        }
    }
}

enum InputType {
    case email
    case password
    case username
    case date
    case gender
    
    func getValidationTypes() -> [ValidationType] {
        switch self {
        case .email:
            return [.notEmpty, .isEmail]
        case .password:
            return [.notEmpty, .requiredLength(3)]
        case .username:
            return [.notEmpty, .requiredLength(4)]
        case .date:
            return [.notEmpty, .isProperDate]
        case .gender:
            return [.notEmpty, .isGender]
        }
    }
}

class FormInput {
    let value: String?
    let inputType: InputType
    
    weak var delegate: InputErrorDelegate?

    init(value: String?, errorDelegate: InputErrorDelegate, inputType: InputType) {
        self.value = value
        self.delegate = errorDelegate
        self.inputType = inputType
    }
}


class Validator {
    
    private var errorCount = 0
    
    var isValid: Bool {
        return errorCount == 0
    }
    
    init(_ inputs: FormDictionary) {
        for (name, input) in inputs {
            if !validate(input, name) {
                errorCount += 1
            }
        }
    }
    
    func validate(_ input: FormInput, _ name: String) -> Bool {
        if let value = input.value {
            for validationType in input.inputType.getValidationTypes() {
                var valid = true
                switch validationType {
                case .notEmpty:
                    valid = !value.isEmpty
                case .isEmail:
                    valid = value.isValidEmail()
                case .requiredLength(let length):
                    valid = value.count >= length
                case .isProperDate:
                    valid = true //do some checking here..
                case .isGender:
                    valid = Constants.genders.contains(where: { $0 == value })
                }
                
                if !valid {
                    input.delegate?.setFailedValidation(validationType)
                    return false
                } else {
                    input.delegate?.setValidState(name)
                }
            }
        }  else {
            input.delegate?.setFailedValidation(.notEmpty)
            return false
        }
        
        return true
    }
    
}
