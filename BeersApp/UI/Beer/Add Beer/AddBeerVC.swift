//
//  AddBeerVC.swift
//  BeersApp
//
//  Created by Marijan on 04/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class AddBeerVC: MenuChildViewController<AddBeerVM>, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tfName: ValidatableTextField!
    @IBOutlet weak var tfDescription: ValidatableTextField!
    @IBOutlet weak var tfAlcohol: ValidatableTextField!
    @IBOutlet weak var tfBitterness: ValidatableTextField!
    @IBOutlet weak var btnCreate: AppButton!
    @IBOutlet weak var ivBeerImage: UIImageView!
    
    private let alcoholPicker = UIPickerView()
    private let bitternessPicker = UIPickerView()
    private let imagePicker = UIImagePickerController()
    
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
                    self.viewModel.imagePath = nil
                case .success(let message):
                    self.showMessage(message)
                    self.viewModel.imagePath = nil
                    self.ivBeerImage.image = nil
                    self.clearFormAndSwitchToSavedBeers()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func clearFormAndSwitchToSavedBeers() {
        tfName.text = nil
        tfDescription.text = nil
        tfAlcohol.text = nil
        tfBitterness.text = nil
        
        if let swRevealVC = self.revealViewController() as? SWRevealVC<MenuVC> {
            swRevealVC.menu?.tvMenu.selectRow(at: IndexPath(row: 1, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition.middle)
            swRevealVC.menu?.delegate?.showController(index: 1, toggleMenu: false)
        }
    }
    
    //if the create button was pressed and the inputs are at original state (no error at just focus) set that they can be marked as invalid
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
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        ivBeerImage.isUserInteractionEnabled = true
        ivBeerImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onImagePressed)))
    }
    
    @objc func onImagePressed() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerView == alcoholPicker ? Constants.alcoholPickerComponentsNo : Constants.bitternessPickerComponentsNo
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == alcoholPicker {
            if component == Constants.decimalPointComponent {
                return Constants.decimalPointComponentRows
            } else {
                return component == 0 ? Constants.alcoholPickerLeftComponentRows : Constants.alcoholPickerRightComponentRows
            }
        } else {
            return Constants.bitternesPickerRows
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
            if component == Constants.decimalPointComponent {
                return Constants.decimalPointWidth
            } else {
                return Constants.alcoholPickerComponentWidth
            }
        } else {
            return Constants.bitternessPickerComponentWidth
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ivBeerImage.contentMode = .scaleAspectFit
            ivBeerImage.image = pickedImage
            
            let fileManager = FileManager.default
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            let imageName = "image\(Date().timeIntervalSince1970).jpg"
            let imagePath = documentsPath?.appendingPathComponent(imageName)

            let imageData = pickedImage.jpegData(compressionQuality: 0.75)
            
            do {
                try imageData?.write(to: imagePath!)
                viewModel.imagePath = imageName
            } catch {
                showMessage("Error saving image")
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}

