//
//  BreweryCell.swift
//  BeersApp
//
//  Created by Marijan on 01/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class BreweryCell: UICollectionViewCell, ReusableCollectionCell {
  
    @IBOutlet weak var ivBrewery: UIImageView!
    @IBOutlet weak var lBreweryName: UILabel!
    
    func configure(with data: Brewery) {
        lBreweryName.text = data.name
        ivBrewery.contentMode = .scaleAspectFit
        ivBrewery.sd_setShowActivityIndicatorView(true)
        ivBrewery.sd_setIndicatorStyle(.gray)
        ivBrewery.sd_setImage(with: URL(string: data.images?.large ?? ""), placeholderImage: #imageLiteral(resourceName: "beer-tap"))
    }
    
}
