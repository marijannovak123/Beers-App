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
    
    public static func promptDialog(parent: UIViewController, message: String, positiveText: String, negativeText: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: positiveText, style: .default, handler: { _ in completion() }))
        alertController.addAction(UIAlertAction(title: negativeText, style: .cancel, handler: nil))
        parent.present(alertController, animated: true, completion: nil)
    }

}
