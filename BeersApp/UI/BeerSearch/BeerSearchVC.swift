//
//  BeerSearchVC.swift
//  BeersApp
//
//  Created by Marijan on 24/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BeerSearchVC: MenuChildViewController<BeerSearchVM> {

    @IBOutlet weak var tvBeers: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func bindToViewModel() {
        let input = BeerSearchVM.Input(
            searchText: tfSearch.rx.text.asDriver()
        )
        
        let output = viewModel.transform(input: input)
        
        output.beers
            .drive(tvBeers.rx.items(cellIdentifier: BeerCell.identifier, cellType: BeerCell.self)) { _, beer, cell in
                cell.configure(with: beer)
            }.disposed(by: disposeBag)
        
        output.isLoading
            .asObservable()
            .subscribe(onNext: { self.showLoading($0) })
            .disposed(by: disposeBag)
        
        let selectionDriver = tvBeers.rx.itemSelected
                                .asDriver()
                                .throttle(0.5)
        
        Driver.combineLatest(selectionDriver, output.beers)
            .asObservable()
            .subscribe(onNext: { [unowned self] indexBeersJoin in
                let (indexPath, beers) = indexBeersJoin
                let beer = beers[indexPath.row]
                self.tvBeers.deselectRow(at: indexPath, animated: true)
                self.navigate(to: .beerDetails(beer: beer))
            }).disposed(by: disposeBag)
       
    }
    
    func setupTableView() {
        tvBeers.registerCell(cellType: BeerCell.self)
        tvBeers.rowHeight = UITableView.automaticDimension
    }
    
    
  
}

