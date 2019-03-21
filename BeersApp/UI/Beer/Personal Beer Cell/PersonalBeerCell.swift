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
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //Do nothing
    }
    
    func configure(with data: PersonalBeer) {
        lName.text = data.name
        lDescription.text = data.description
        
        if let imageName = data.localImagePath {
            let fileManager = FileManager.default
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            let imagePath = documentsPath?.appendingPathComponent(imageName).path
            ivImage.image = UIImage(contentsOfFile: imagePath!)
        } 
    }
    
}
