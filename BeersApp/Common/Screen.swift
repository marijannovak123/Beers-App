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
    case brewerySearch
    case addBeer
    case beerDetails(beer: Beer)
    case locations
    case game
    case beerWeb
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
            controller = container?.resolve(SWRevealVC<MenuVC>.self)
        case .beerDetails(let beer):
            controller = container?.resolve(BeerDetailsVC.self, argument: beer)
        case .brewerySearch:
            controller = container?.resolve(BreweriesSearchVC.self)
        case .addBeer:
            controller = container?.resolve(AddBeerVC.self)
        case .locations:
            controller = container?.resolve(NearbyLocationsVC.self)
        case .game:
            controller = container?.resolve(GameVC.self)
        case .beerWeb:
            controller = container?.resolve(BeerWebVC.self)
        }
        
        if self.isRootController() {
            return UINavigationController(rootViewController: controller!)
        } else {
            return controller
        }
    }
    
    func isRootController() -> Bool {
        switch self {
        case .beerDetails, .menu:
            return false
        default:
            return true
        }
    }
}

