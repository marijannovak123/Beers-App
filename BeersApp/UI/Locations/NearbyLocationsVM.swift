//
//  NearbyLocationsVM.swift
//  BeersApp
//
//  Created by Marijan on 06/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxCocoa

class NearbyLocationsVM: ViewModelType {
    
    struct Input {}
    struct Output {
        let locationsDriver: Driver<[Location]>
        let isLoading: Driver<Bool>
    }
    
    private let repository: LocationRepository
    private let activityIndicator = ActivityIndicator()
    
    init(repository: LocationRepository) {
        self.repository = repository
    }
    
    func transform(input: NearbyLocationsVM.Input) -> NearbyLocationsVM.Output {
        let locationsDriver = self.repository.fetchLocations()
            .trackActivity(activityIndicator)
            .asDriver(onErrorJustReturn: [])
        
        return Output(locationsDriver: locationsDriver, isLoading: activityIndicator.asDriver())
    }
}
