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
            ).filter { [unowned self] parameters in
                self.isInputValid(parameters: parameters)
            }.map { [unowned self] parameters in
                self.generateBeer(parameters: parameters)
            }.asObservable()
            .flatMap { [unowned self] beer in
                self.repository.savePersonalBeer(beer)
            }.map { _ in
                UIResult.success("Beer created successsfully!")
            }.asDriver(onErrorJustReturn:
                UIResult.error("Error creating beer")
            )
        
        return Output(beerCreatedDriver: beerCreatedDriver)
    }
    
    private func generateBeer(parameters: AddBeerInput) -> PersonalBeer {
        return PersonalBeer(id: String.generateRandomId(length: 6), name: parameters.name.value!, description: parameters.description.value!, abv: parameters.abv.value!, ibu: parameters.ibu.value!, localImagePath: "")
    }
    
    private func isInputValid(parameters: AddBeerInput) -> Bool {
        return parameters.name.isValid && parameters.description.isValid && parameters.abv.isValid && parameters.ibu.isValid
    }
}
