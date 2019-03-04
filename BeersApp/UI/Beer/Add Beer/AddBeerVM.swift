//
//  MyBeersVM.swift
//  BeersApp
//
//  Created by Marijan on 04/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxCocoa

class AddBeerVM: ViewModelType {
    
    //text inputs could all be combined in an array for nicer validity filtering
    struct Input {
        let createButtonDriver: Driver<Void>
        let nameDriver: Driver<ValidatedText>
        let descriptionDriver: Driver<ValidatedText>
        let alcoholDriver: Driver<ValidatedText>
        let bitternessDriver: Driver<ValidatedText>
    }
    
    struct Output {
        let beerCreatedDriver: Driver<UIResult>
    }
    
    private let repository: BeerRepository
    
    init(repository: BeerRepository) {
        self.repository = repository
    }
    
    func transform(input: AddBeerVM.Input) -> AddBeerVM.Output {
        let beerCreatedDriver = input.createButtonDriver
            .withLatestFrom (
                Driver.combineLatest(input.nameDriver, input.descriptionDriver, input.alcoholDriver, input.bitternessDriver)
            ).filter { parameters -> Bool in
                let (name, description, alcohol, bitterness) = parameters
                return name.isValid && description.isValid && alcohol.isValid && bitterness.isValid
            }.map { parameters -> PersonalBeer in
                let (name, description, alcohol, bitterness) = parameters
                return PersonalBeer(id: String.generateRandomId(length: 6), name: name.value!, description: description.value!, abv: alcohol.value!, ibu: bitterness.value!)
            }.asObservable()
            .map { $0.asBeer() }
            .flatMap { beer in
                self.repository.saveBeer(beer)
            }.map {
                UIResult(message: "Beer created successsfully!", isError: false)
            }.asDriver( onErrorJustReturn:
                UIResult(message: "Error creating beer", isError: true)
            )
        
        return Output(beerCreatedDriver: beerCreatedDriver)
    }
}
