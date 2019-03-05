//
//  MyBeersVM.swift
//  BeersApp
//
//  Created by Marijan on 04/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxCocoa

typealias AddBeerInput = (name: ValidatedText, description: ValidatedText, abv: ValidatedText, ibu: ValidatedText)

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
            ).filter { [unowned self] in
                self.isInputValid(parameters: $0)
            }.map { [unowned self] in
                self.generateBeer(parameters: $0)
            }.asObservable()
            .flatMap { [unowned self] beer in
                self.repository.saveBeer(beer)
            }.map { _ in
                UIResult.success("Beer created successsfully!")
            }.asDriver( onErrorJustReturn:
                UIResult.error("Error creating beer")
            )
        
        return Output(beerCreatedDriver: beerCreatedDriver)
    }
    
    private func generateBeer(parameters: AddBeerInput) -> Beer {
        return PersonalBeer(id: String.generateRandomId(length: 6), name: parameters.name.value!, description: parameters.description.value!, abv: parameters.abv.value!, ibu: parameters.ibu.value!).asBeer()
    }
    
    private func isInputValid(parameters: AddBeerInput) -> Bool {
        return parameters.name.isValid && parameters.description.isValid && parameters.abv.isValid && parameters.ibu.isValid
    }
}
