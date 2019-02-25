//
//  MenuItemCell.swift
//  BeersApp
//
//  Created by Marijan on 25/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var ivItemIcon: UIImageView!
    @IBOutlet weak var ivItemName: UILabel!
    
    func configure(with data: MenuItem) {
        ivItemIcon.image = data.icon
        ivItemName.text = data.title
    }
    
}
