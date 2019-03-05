//
//  SWRevealVC.swift
//  BeersApp
//
//  Created by Marijan on 25/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit
import SWRevealViewController

class SWRevealVC<T: MenuType>: SWRevealViewController {
    
    weak var menu: T? {
        didSet {
            self.menu?.delegate = self
            self.frontViewController = menu?.viewControllers.first
            self.rearViewController = menu
        }
    }
    
    private var selection: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.width * 0.75
        self.rearViewRevealWidth = width
    }
    
    deinit {
        menu?.dismissMenu(animated: true)
    }
    
}

extension SWRevealVC: MenuDelegate {
    
    func showController(index: Int, toggleMenu: Bool) {
        if let viewControllers = menu?.viewControllers, index < viewControllers.count && index != selection {
            let controller = viewControllers[index]
            self.setFront(controller, animated: true)
            self.selection = index
        }
        
        if toggleMenu {
            self.revealToggle(animated: true)
        }

    }
    
}
