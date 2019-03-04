//
//  BreweriesSearchVC.swift
//  BeersApp
//
//  Created by Marijan on 27/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit
import RxDataSources

class BreweriesSearchVC: MenuChildViewController<BreweriesSearchVM>, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var cvBreweries: UICollectionView!
    @IBOutlet weak var sbBreweryName: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cvBreweries.registerCell(cellType: BreweryCell.self)
        cvBreweries.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

    override func bindToViewModel() {
        let input = BreweriesSearchVM.Input(searchText: sbBreweryName.rx.text.asDriver())
        let output = viewModel.transform(input: input)
        
        output.isLoading
            .drive(onNext: { [unowned self] in
                self.showLoading($0)
            })
            .disposed(by: disposeBag)
        
        output.breweriesSections
            .debug()
            .drive(cvBreweries.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }

    var dataSource: RxCollectionViewSectionedAnimatedDataSource<BrewerySection> {
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<BrewerySection>(configureCell: { ds, cv, ip, brewery in
            let cell = cv.dequeueReusableCell(cellType: BreweryCell.self, for: ip)!
            cell.configure(with: brewery)
            return cell
        })
        
        dataSource.animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                                   reloadAnimation: .automatic,
                                                                   deleteAnimation: .automatic)
        
        return dataSource
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
    
}
