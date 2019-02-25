//
//  BeerCell.swift
//  BeersApp
//
//  Created by Marijan on 24/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class BeerCell: UITableViewCell, ReusableCell {
    
    
    @IBOutlet weak var ivBeerImage: UIImageView!
    @IBOutlet weak var lName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutMargins = UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func configure(with data: Beer) {
        lName.text = data.name
    }
    
}
