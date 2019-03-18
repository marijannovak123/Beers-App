//
//  PersonalBeerCell.swift
//  BeersApp
//
//  Created by UHP Mac on 18/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class PersonalBeerCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var lABV: UILabel!
    @IBOutlet weak var lIBU: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //Do nothing
    }
    
    func configure(with data: PersonalBeer) {
        lName.text = data.name
        lABV.text = data.abv
        lIBU.text = data.ibu
        ivImage.image = UIImage(named: "beer")
        lDescription.text = data.description
    }
    
}
