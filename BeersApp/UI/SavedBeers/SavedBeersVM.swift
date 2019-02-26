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
        let itemDeleted: Driver<Beer>
    }
    
    struct Output {
        let beersSection: Driver<[BeerSection]>
        let deleteResult: Driver<(String, Bool)>
    }
    
    private let repository: BeerRepository
    
    init(repository: BeerRepository) {
        self.repository = repository
    }
    
    func transform(input: SavedBeersVM.Input) -> SavedBeersVM.Output {
        let beerDriver = repository.loadPersistedBeers()
            .map { [BeerSection(beers: $0, header: "Persisted Beers")] }
            .asDriver(onErrorJustReturn: [])
        
        let deleteDriver = input.itemDeleted
            .debug()
            .asObservable()
            .flatMap { beer in
                self.deleteBeer(beer)
            }.map { ("Successfully deleted.", true) }
            .asDriver(onErrorJustReturn: ("Error deleting beer.", false))
       
        return Output(beersSection: beerDriver, deleteResult: deleteDriver)
    }
    
    func deleteBeer(_ beer: Beer) -> Observable<Void> {
        return repository.deleteBeer(beer)
    }
    
}
