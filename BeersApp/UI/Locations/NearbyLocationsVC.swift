//
//  NearbyLocationsVC.swift
//  BeersApp
//
//  Created by Marijan on 06/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit
import MapKit

class NearbyLocationsVC: MenuChildViewController<NearbyLocationsVM> {
   
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "locations".localized
    }

    override func bindToViewModel() {
        let output = viewModel.transform(input: NearbyLocationsVM.Input())
        
        output.locationsDriver
            .drive(onNext: { [unowned self] locations in
                self.setLocationMarksOnMap(locations)
            }
        ).disposed(by: disposeBag)
        
        output.isLoading
            .drive(onNext: { [unowned self] in
                self.showLoading($0)
            })
            .disposed(by: disposeBag)
    }
    
    func setLocationMarksOnMap(_ locations: [Location]) {
        print(locations)
    }
}
