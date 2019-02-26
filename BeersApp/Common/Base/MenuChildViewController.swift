//
//  MenuChildViewController.swift
//  BeersApp
//
//  Created by Marijan on 25/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class MenuChildViewController<V>: BaseViewController<V> where V: ViewModelType {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMenuButton()
    }
    
    func addMenuButton() {
        self.revealViewController()?.tapGestureRecognizer()
        self.revealViewController()?.panGestureRecognizer().isEnabled = true
    
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(toggleReveal))
    }
    
    @objc private func toggleReveal() {
        self.revealViewController()?.revealToggle(animated: true)
    }
    
}
