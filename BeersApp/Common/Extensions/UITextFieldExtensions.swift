import UIKit

extension UITextField: InputErrorDelegate {
    
    func setValidState(_ placeholder: String?) {
        self.clearsOnBeginEditing = false
        self.placeholder = placeholder ?? ""
        self.layer.borderWidth = 0
    }
    
    func setFailedValidation(_ failedValidation: ValidationType) {
        setError(message: failedValidation.resolveFailedValidationMessage())
        
    }
    
    func setError(message: String) {
        self.text = ""
        self.clearsOnBeginEditing = true
        self.placeholder = message
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    }
    
    func toFormInput(inputType: InputType) -> FormInput {
        return FormInput(value: self.text, errorDelegate: self, inputType: inputType)
    }
    
}

