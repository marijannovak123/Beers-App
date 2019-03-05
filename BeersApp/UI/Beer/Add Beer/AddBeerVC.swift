//
//  AddBeerVC.swift
//  BeersApp
//
//  Created by Marijan on 04/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class AddBeerVC: MenuChildViewController<AddBeerVM> {
    
    @IBOutlet weak var tfName: ValidatableTextField!
    @IBOutlet weak var tfDescription: ValidatableTextField!
    @IBOutlet weak var tfAlcohol: ValidatableTextField!
    @IBOutlet weak var tfBitterness: ValidatableTextField!
    @IBOutlet weak var btnCreate: AppButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValidation()
    }

    override func bindToViewModel() {
        let input = AddBeerVM.Input(
            createButtonDriver: btnCreate.rx.tap.asDriver(),
            nameDriver: tfName.validatedText,
            descriptionDriver: tfDescription.validatedText,
            alcoholDriver: tfAlcohol.validatedText,
            bitternessDriver: tfBitterness.validatedText
        )
        
        let output = viewModel.transform(input: input)
        
        output.beerCreatedDriver
            .drive(onNext: { result in
                switch result {
                case .error(let message):
                    self.showErrorMessage(message)
                case .success(let message):
                    self.showMessage(message!)
                }
            })
            .disposed(by: disposeBag)
    }

    func setValidation() {
        tfName.inputType = .regularText
        tfDescription.inputType = .regularText
        tfAlcohol.inputType = .regularText
        tfBitterness.inputType = .regularText
    }
}
