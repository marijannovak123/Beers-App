//
//  SavedBeersVC.swift
//  BeersApp
//
//  Created by Marijan on 25/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class SavedBeersVC: MenuChildViewController<SavedBeersVM> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Saved Beers"
    }
    
    override func bindToViewModel() {
        let input = SavedBeersVM.Input()
        let output = viewModel.transform(input: input)
        
        
    }

}
