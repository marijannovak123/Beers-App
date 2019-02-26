//
//  SavedBeersVM.swift
//  BeersApp
//
//  Created by Marijan on 25/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SavedBeersVM: ViewModelType {
  
    struct Input {
        
    }
    
    struct Output {
        let beers: Driver<[Beer]>
    }
    
    private let repository: BeerRepository
    
    init(repository: BeerRepository) {
        self.repository = repository
    }
    
    func transform(input: SavedBeersVM.Input) -> SavedBeersVM.Output {
        let beerDriver = repository.loadPersistedBeers()
            .asDriver(onErrorJustReturn: [])
        
        return Output(beers: beerDriver)
    }
    
}
