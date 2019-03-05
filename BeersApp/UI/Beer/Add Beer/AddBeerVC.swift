//
//  AddBeerVC.swift
//  BeersApp
//
//  Created by Marijan on 04/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class AddBeerVC: MenuChildViewController<AddBeerVM>, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tfName: ValidatableTextField!
    @IBOutlet weak var tfDescription: ValidatableTextField!
    @IBOutlet weak var tfAlcohol: ValidatableTextField!
    @IBOutlet weak var tfBitterness: ValidatableTextField!
    @IBOutlet weak var btnCreate: AppButton!
    
    private let alcoholPicker = UIPickerView()
    private let bitternessPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValidation()
        setPickers()
    }

    override func bindToViewModel() {
        let createButtonDriver = btnCreate.rx.tap
            .asDriver()
            .do(onNext: { [unowned self] in
                self.enableTextFieldErrors()
            })
        
        let input = AddBeerVM.Input(
            createButtonDriver: createButtonDriver,
            nameDriver: tfName.validatedText,
            descriptionDriver: tfDescription.validatedText,
            alcoholDriver: tfAlcohol.validatedText,
            bitternessDriver: tfBitterness.validatedText
        )
        
        let output = viewModel.transform(input: input)
        
        output.beerCreatedDriver
            .drive(onNext: { [unowned self] result in
                switch result {
                case .error(let message):
                    self.showErrorMessage(message)
                case .success(let message):
                    self.showMessage(message!)
                    if let swRevealVC = self.revealViewController() as? SWRevealVC<MenuVC> {
                        swRevealVC.showController(index: 1, toggleMenu: false)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    func enableTextFieldErrors() {
        if tfName.isAtOriginalState || tfDescription.isAtOriginalState || tfBitterness.isAtOriginalState || tfAlcohol.isAtOriginalState {
            tfBitterness.isAtOriginalState = false
            tfAlcohol.isAtOriginalState = false
            tfName.isAtOriginalState = false
            tfDescription.isAtOriginalState = false
            
            _ = tfName.validate()
            _ = tfDescription.validate()
            _ = tfBitterness.validate()
            _ = tfAlcohol.validate()
        }
    }

    func setValidation() {
        //default is already not empty (regularText)..set some other input type if needed
    }
    
    func setPickers() {
        alcoholPicker.backgroundColor = UIColor.white
        bitternessPicker.backgroundColor = UIColor.white
        alcoholPicker.delegate = self
        alcoholPicker.dataSource = self
        bitternessPicker.delegate = self
        bitternessPicker.dataSource = self
        
        tfAlcohol.inputView = alcoholPicker
        tfBitterness.inputView = bitternessPicker
    }
    
    @objc func setAlcohol(_ sender: UIPickerView) {
        
    }
    
    @objc func setBitterness(_ sender: UIPickerView) {
       
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerView == alcoholPicker ? 3 : 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == alcoholPicker {
            if component == 1 {
                return 1
            } else {
                return component == 0 ? 11 : 10
            }
        } else {
            return 13
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == alcoholPicker {
            if component == 1 {
                return Locale.current.decimalSeparator
            } else {
                return String(row)
            }
        } else {
            return String(row * 10)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == alcoholPicker {
            let wholePart = pickerView.selectedRow(inComponent: 0)
            let decimalPart = pickerView.selectedRow(inComponent: 2)
            
            let alcoholString = "\(wholePart)\(Locale.current.decimalSeparator ?? ",")\(decimalPart)"
            tfAlcohol.text = alcoholString
        } else {
            let bitterness = pickerView.selectedRow(inComponent: 0) * 10
            tfBitterness.text = String(bitterness)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if pickerView == alcoholPicker {
            if component == 1 {
                return 20
            } else {
                return 40
            }
        } else {
            return 50
        }
    }
}

