//
//  BeerCell.swift
//  BeersApp
//
//  Created by Marijan on 24/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class BeerCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var ivBeer: UIImageView!
    @IBOutlet weak var lBeerName: UILabel!
    
    func configure(with data: Beer) {
        lBeerName.text = data.name
    }
    
}
