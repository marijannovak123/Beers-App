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
    
    private let expandedIndexRelay = BehaviorRelay.init(value: -1)
    
    struct Input {
        let itemDeleted: Driver<Beer>
    }
    
    struct Output {
        let beersSection: Driver<[BeerSection]>
        let deleteResult: Driver<UIResult>
        let beerCount: Driver<Int>
    }
    
    private let repository: BeerRepository
    
    init(repository: BeerRepository) {
        self.repository = repository
    }
    
    func transform(input: SavedBeersVM.Input) -> SavedBeersVM.Output {
        let beerDriver = Observable.combineLatest(expandedIndexRelay.asObservable(), repository.loadPersistedBeers()) {
            expandedIndex, beers -> [BeerWrapper] in
                var beerWrappers = [BeerWrapper]()
                for (index, beer) in beers.enumerated() {
                    beerWrappers.append(BeerWrapper(beer: beer, isExpanded: (expandedIndex == index), index: index))
                }
                return beerWrappers
            }
            .map { [BeerSection(beers: $0, header: nil)] }
            .asDriver(onErrorJustReturn: [])
        
        let deleteDriver = input.itemDeleted
            .asObservable()
            .flatMap { [unowned self] beer in
                self.deleteBeer(beer)
            }.map { UIResult(message: "delete_success".localized, isError: false) }
            .asDriver(onErrorJustReturn: UIResult(message: "delete_error".localized, isError: true))
       
        let beerCount = beerDriver.map {
            $0.first?.beers.count ?? 0
        }
        
        return Output(beersSection: beerDriver, deleteResult: deleteDriver, beerCount: beerCount)
    }
    
    func deleteBeer(_ beer: Beer) -> Observable<Void> {
        return repository.deleteBeer(beer)
    }
    
    func setExpandedCell(at index: Int) {
        self.expandedIndexRelay.accept(index)
    }
}
