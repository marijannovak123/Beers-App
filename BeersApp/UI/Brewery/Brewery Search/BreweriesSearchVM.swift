//
//  BrewerySearchVM.swift
//  BeersApp
//
//  Created by Marijan on 27/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class BreweriesSearchVM: ViewModelType {
    
    private let activityIndicator = ActivityIndicator()
    
    struct Input {
        let searchText: Driver<String?>
    }
    
    struct Output {
        let breweriesSections: Driver<[BrewerySection]>
        let isLoading: Driver<Bool>
    }
    
    private let repository: BreweryRepository
    
    init(repository: BreweryRepository) {
        self.repository = repository
    }
    
    func transform(input: BreweriesSearchVM.Input) -> BreweriesSearchVM.Output {
        let breweriesDriver = input.searchText
            .debounce(0.5)
            .filter { $0 != nil }
            .asObservable()
            .flatMap { [unowned self] in
                self.repository.getBreweriesByName(name: $0!)
            }.map {
                [BrewerySection(breweries: $0, header: nil)]
            }.trackActivity(activityIndicator)
            .asDriver(onErrorJustReturn: [])
        
        return Output(breweriesSections: breweriesDriver, isLoading: activityIndicator.asDriver())
    }
}
