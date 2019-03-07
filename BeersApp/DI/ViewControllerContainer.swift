//
//  ViewControllerContainer.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Swinject

class ViewControllerContainer {
    
    static func build(viewModelContainer: Container) -> Container {
        let container = Container(parent: viewModelContainer)
        
        container.register(BeerSearchVC.self) {
            BeerSearchVC(viewModel: $0.resolve(BeerSearchVM.self)!)
        }
        
        container.register(SavedBeersVC.self) {
            SavedBeersVC(viewModel: $0.resolve(SavedBeersVM.self)!)
        }
        
        container.register(MenuVC.self) { _ in
            MenuVC(items: MenuItem.allValues)
        }
        
        container.register(SWRevealVC<MenuVC>.self) {
            let swRevealVC = SWRevealVC<MenuVC>()
            swRevealVC.menu = $0.resolve(MenuVC.self)!
            return swRevealVC
        }
        
        container.register(BeerDetailsVC.self) { (resolver: Resolver, beer: Beer) in
            BeerDetailsVC(beer: beer)
        }
        
        container.register(AddBeerVC.self) {
            AddBeerVC(viewModel: $0.resolve(AddBeerVM.self)!)
        }
        
        container.register(BreweriesSearchVC.self) {
            BreweriesSearchVC(viewModel: $0.resolve(BreweriesSearchVM.self)!)
        }
        
        container.register(NearbyLocationsVC.self) {
            NearbyLocationsVC(viewModel: $0.resolve(NearbyLocationsVM.self)!)
        }
        
        container.register(GameVC.self) { _ in
            GameVC()
        }
        
        return container
    }
}
