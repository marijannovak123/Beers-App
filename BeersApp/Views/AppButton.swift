//
//  AppButton.swift
//  BeersApp
//
//  Created by Marijan on 04/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class AppButton: UIButton {
    
    @IBInspectable var background: UIColor = Colors.buttonColor {
        didSet {
            self.backgroundColor = background
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 6.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        self.backgroundColor = self.background
        self.layer.cornerRadius = self.cornerRadius
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
    }
}
