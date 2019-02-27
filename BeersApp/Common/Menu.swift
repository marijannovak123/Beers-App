//
//  Menu.swift
//  BeersApp
//
//  Created by Marijan on 25/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

protocol MenuDelegate: class {
    func showController(index: Int)
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
    
    var screen: Screen? {
        switch self {
        case .beerSearch:
            return .beerSearch
        case .savedBeers:
            return .savedBeers
        }
    }
    
    var title: String {
        switch self {
        case .beerSearch:
            return "browse_beers".localized
        case .savedBeers:
            return "saved_beers".localized
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .beerSearch:
            return #imageLiteral(resourceName: "search")
        case .savedBeers:
            return #imageLiteral(resourceName: "save")
        }
    }
    
    static var allValues: [MenuItem] {
        return [.beerSearch, .savedBeers]
    }
}

