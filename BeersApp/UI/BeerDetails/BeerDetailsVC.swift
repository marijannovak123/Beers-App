//
//  BeerDetailsVC.swift
//  BeersApp
//
//  Created by Marijan on 25/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class BeerDetailsVC: UIViewController {

    @IBOutlet weak var lBeerName: UILabel!
    
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
        setBeerData()
    }

    private func setBeerData() {
        lBeerName.text = beer.name
    }
}
