//
//  MyBeersVM.swift
//  BeersApp
//
//  Created by Marijan on 04/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

class AddBeerVM: ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    private let repository: BeerRepository
    
    init(repository: BeerRepository) {
        self.repository = repository
    }
    
    func transform(input: AddBeerVM.Input) -> AddBeerVM.Output {
        return Output()
    }
}
