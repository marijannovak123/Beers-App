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
        let selectionTrigger: Driver<IndexPath>
        let saveTrigger: Driver<SwipeEvent>
    }
    
    struct Output {
        let isLoading: Driver<Bool>
        let beersSection: Driver<[SectionModel<String,Beer>]>
        let beerCount: Driver<Int>
        let saveResult: Driver<UIResult>
        let selectionResult: Driver<Beer?>
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
        
        let beerSectionDriver = beerDriver.map { [SectionModel(model: "Beers", items: $0)] }
        
        let beerCount = beerDriver.map { $0.count }
        
        let saveResult = input.saveTrigger
            .withLatestFrom(beerDriver) { ($0, $1) }
            .asObservable()
            .flatMap { [unowned self] (parameters) -> Observable<Void> in
                let (swipeEvent, beers) = parameters
                let beer = beers[swipeEvent.indexPath.row]
                return self.saveBeer(beer)
            }.map {
                UIResult(message: "persist_success".localized, isError: false)
            }.asDriver(onErrorJustReturn:
                UIResult(message: "persist_error".localized, isError: true)
            )
        
        let selectionResult = input.selectionTrigger
            .withLatestFrom(beerDriver) { ($0, $1) }
            .asObservable()
            .map { (selectionBeerJoin) -> Beer in
                let (indexPath, beers) = selectionBeerJoin
                return beers[indexPath.row]
            }.asDriver(onErrorJustReturn: nil)
        
        return Output(
            isLoading: activityTracker.asDriver(),
            beersSection: beerSectionDriver,
            beerCount: beerCount,
            saveResult: saveResult,
            selectionResult: selectionResult
        )
    }
    
    func saveBeer(_ beer: Beer) -> Observable<Void> {
        return repository.saveBeer(beer)
    }
    
}
