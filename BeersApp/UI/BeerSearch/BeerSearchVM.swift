//
//  BeerSearchVM.swift
//  BeersApp
//
//  Created by Marijan on 24/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

class BeerSearchVM: ViewModelType {

    private let repository: BeerRepository
    
    private let activityTracker = ActivityIndicator()
    
    init(repository: BeerRepository) {
        self.repository = repository
    }
    
    struct Input {
        let searchText: Driver<String?>
    }
    
    struct Output {
        let isLoading: Driver<Bool>
        let beersSection: Driver<[SectionModel<String,Beer>]>
        let beers: Driver<[Beer]>
    }
    
    func transform(input: BeerSearchVM.Input) -> BeerSearchVM.Output {
        
        let beerDriver = input.searchText
            .debounce(0.5)
            .filter { $0 != nil }
            .asObservable()
            .flatMap { [unowned self] query in
                self.repository.fetchBeers(query: query!)
            }.trackActivity(activityTracker)
            .asDriver(onErrorJustReturn: [])
        
        let beerSectionDriver = beerDriver.map {
            [SectionModel(model: "Beers", items: $0)]
        }
        
        return Output(isLoading: activityTracker.asDriver(), beersSection: beerSectionDriver, beers: beerDriver)
    }
    
    func saveBeer(_ beer: Beer) -> Observable<Void> {
        return repository.saveBeer(beer)
    }
}
