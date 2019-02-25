//
//  Navigator.swift
//  ios learning
//
//  Created by UHP Digital Mac 3 on 31.01.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

enum Screen {
    
    case beerSearch
    case savedBeers
    case beerDetails(beer: Beer)
    case menu
    
    func getController() -> UIViewController? {
        let container = AppDelegate.instance.viewControllerContainer
        
        var controller: UIViewController?
        switch self {
        case .beerSearch:
            controller = container?.resolve(BeerSearchVC.self)
        case .savedBeers:
            controller = container?.resolve(SavedBeersVC.self)
        case .menu:
            return container?.resolve(SWRevealVC<MenuVC>.self)
        case .beerDetails(let beer):
            return container?.resolve(BeerDetailsVC.self, argument: beer)
        }
        
        if self.isRootController() {
            return UINavigationController(rootViewController: controller!)
        } else {
            return controller
        }
    }
    
    func isRootController() -> Bool {
        switch self {
        case .beerSearch, .savedBeers:
            return true
        default:
            return false
        }
    }
}

