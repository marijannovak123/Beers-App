//
//  BreweryCell.swift
//  BeersApp
//
//  Created by Marijan on 01/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit
import Kingfisher

class BreweryCell: UICollectionViewCell, ReusableCollectionCell {
  
    @IBOutlet weak var ivBrewery: UIImageView!
    @IBOutlet weak var lBreweryName: UILabel!
    
    func configure(with data: Brewery) {
        lBreweryName.text = data.name
        ivBrewery.contentMode = .scaleAspectFit
        ivBrewery.kf.indicatorType = .activity
        ivBrewery.kf.setImage(with: URL(string: data.images?.large ?? ""), placeholder: #imageLiteral(resourceName: "beer-tap"), options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
            ])
    }
    
}
