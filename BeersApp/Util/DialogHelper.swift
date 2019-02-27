//
//  DialogHelper.swift
//  ios learning
//
//  Created by UHP Digital Mac 3 on 01.02.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class DialogHelper {
    
    private init() {}
    
    public static func infoDialog(from parent: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    
        parent.present(alertController, animated: true, completion: nil)
    }
    
    public static func errorDialog(from parent: UIViewController, message: String) {
        infoDialog(from: parent, title: "error".localized, message: message)
    }
}
