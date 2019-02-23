//
//  CustomButton.swift
//  ios learning
//
//  Created by UHP Digital Mac 3 on 05.02.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class AppButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 6.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var textColor: UIColor = UIColor.white {
        didSet {
            self.setTitleColor(textColor, for: .normal)
        }
    }
    
    @IBInspectable var bgColor: UIColor = Colors.buttonColor {
        didSet {
            self.backgroundColor = bgColor
        }
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        self.layer.cornerRadius = cornerRadius
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = bgColor
        self.titleEdgeInsets = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    
}

