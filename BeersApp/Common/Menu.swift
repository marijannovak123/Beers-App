//
//  Menu.swift
//  BeersApp
//
//  Created by Marijan on 25/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

protocol MenuDelegate: class {
    func showController(index: Int, toggleMenu: Bool)
}

protocol MenuType where Self: UIViewController {
    var items: [MenuItem] { get }
    var viewControllers: [UIViewController] { get }
    var delegate: MenuDelegate? { get set }
    
    func dismissMenu(animated: Bool)
}

enum MenuItem {
   
    case beerSearch
    case savedBeers
    case brewerySearch
    case addBeer
    case locations
    case game
    
    var screen: Screen? {
        switch self {
        case .beerSearch:
            return .beerSearch
        case .savedBeers:
            return .savedBeers
        case .brewerySearch:
            return .brewerySearch
        case .addBeer:
            return .addBeer
        case .locations:
            return .locations
        case .game:
            return .game
        }
    }

    var title: String {
        switch self {
        case .beerSearch:
            return "browse_beers".localized
        case .savedBeers:
            return "saved_beers".localized
        case .brewerySearch:
            return "breweries".localized
        case .addBeer:
            return "my_beers".localized
        case .locations:
            return "locations".localized
        case .game:
            return "game".localized
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .beerSearch:
            return #imageLiteral(resourceName: "search")
        case .savedBeers:
            return #imageLiteral(resourceName: "save")
        case .brewerySearch:
            return #imageLiteral(resourceName: "beer-tap")
        case .addBeer:
            return #imageLiteral(resourceName: "beer")
        case .locations:
            return #imageLiteral(resourceName: "location")
        case .game:
            return #imageLiteral(resourceName: "game")
        }
    }
    
    static var allValues: [MenuItem] {
        return [.beerSearch, .savedBeers, .brewerySearch, .addBeer, .locations, .game]
    }
}

