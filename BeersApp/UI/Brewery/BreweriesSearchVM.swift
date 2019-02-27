//
//  BrewerySearchVM.swift
//  BeersApp
//
//  Created by Marijan on 27/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

class BreweriesSearchVM: ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    private let repository: BreweryRepository
    
    init(repository: BreweryRepository) {
        self.repository = repository
    }
    
    func transform(input: BreweriesSearchVM.Input) -> BreweriesSearchVM.Output {
        return Output()
    }
}
