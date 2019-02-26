//
//  BeerDetailsVC.swift
//  BeersApp
//
//  Created by Marijan on 25/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit
import SDWebImage

class BeerDetailsVC: UIViewController {

    @IBOutlet weak var lBeerName: UILabel!
    @IBOutlet weak var ivBeerImage: UIImageView!
    
    private let beer: Beer
    
    init(beer: Beer) {
        self.beer = beer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        setBeerData()
    }

    private func setBeerData() {
        lBeerName.text = beer.name
        ivBeerImage.sd_setImage(with: URL(string: beer.labels?.large ?? ""))
    }
}
