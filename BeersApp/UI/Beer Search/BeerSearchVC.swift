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

class BeerSearchVC: BaseViewController<BeerSearchVM> {

    @IBOutlet weak var tvBeers: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvBeers.registerCell(cellType: BeerCell.self)
    }

    override func bindToViewModel() {
        let searchTextDriver = tfSearch.rx.text.asDriver()
        let input = BeerSearchVM.Input(searchText: searchTextDriver)
        let output = viewModel.transform(input: input)
        
//    output.beers
//        .drive(tvBeers.rx.items(cellIdentifier: BeerCell.identifier)) { _, beer, cell in
//                cell.configure(with: beer)
//            }.disposed(by: disposeBag)
        
        output.beers.asObservable()
            .bind(to: tvBeers.rx.items(cellIdentifier: BeerCell.identifier, cellType: BeerCell.self)) { _, beer, cell in
                cell.configure(with: beer)
            }.disposed(by: disposeBag)
    }
  
}
