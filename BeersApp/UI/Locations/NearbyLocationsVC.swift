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
    
    private var mapMarkers = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "locations".localized
        mapView.showsScale = true
        mapView.showsUserLocation = true
        mapView.setRegion(MKCoordinateRegion.init(mapView.visibleMapRect), animated: true)
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
        mapView.removeAnnotations(mapMarkers)
        mapMarkers.removeAll()
        
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.title = location.name
            mapMarkers.append(annotation)
        }
        
        mapView.addAnnotations(mapMarkers)
        
        if locations.count > 0 {
            setRegionToFirstMarker(locations[0])
        }
    }
    
    func setRegionToFirstMarker(_ location: Location) {
        let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000000, longitudinalMeters: 10000000)
        mapView.setRegion(region, animated: true)
    }
}
