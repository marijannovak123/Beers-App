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
        let itemDeleted: Driver<BeerWrapper>
        let allDeleted: Driver<Void>
    }
    
    struct Output {
        let beersSection: Driver<[BeerSection]>
        let personalBeersSection: Driver<[PersonalBeerSection]>
        let deleteResult: Driver<UIResult>
        let deleteAllResult: Driver<UIResult>
        let anyBeers: Driver<Bool>
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
            .map { [BeerSection(beers: $0, header: "Saved Beers")] }
            .asDriver(onErrorJustReturn: [])
        
        let personalBeerDriver = repository.loadPersonalBeers()
            .map { [PersonalBeerSection(beers: $0, header: "Personal Beers")] }
            .asDriver(onErrorJustReturn: [])
        
        let deleteDriver = input.itemDeleted
            .asObservable()
            .flatMap { [unowned self] beerWrapper in
                 self.repository.deleteBeer(beerWrapper.beer)
            }.map { _ in .success("delete_success".localized) }
            .asDriver(onErrorJustReturn: UIResult.error("delete_error".localized))
       
        let deleteAllDriver = input.allDeleted
            .asObservable()
            .flatMap { _ in
                self.repository.deleteAllBeers()
            }.map { _ in .success("delete_success".localized) }
            .asDriver(onErrorJustReturn: UIResult.error("delete_error".localized))
        
        let beerCount = beerDriver.map {
            $0.first?.beers.count ?? 0
        }
        
        let personalBeerCount = personalBeerDriver.map {
            $0.first?.beers.count ?? 0
        }
            
        let anyBeers = Driver.combineLatest(beerCount, personalBeerCount) { beersNo, personalBeersNo in
            beersNo > 0 || personalBeersNo > 0
        }
        
        return Output(beersSection: beerDriver, personalBeersSection: personalBeerDriver, deleteResult: deleteDriver, deleteAllResult: deleteAllDriver, anyBeers: anyBeers)
    }
    
    func setExpandedCell(at index: Int) {
        self.expandedIndexRelay.accept(index)
    }
}
