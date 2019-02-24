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
        setupTableView()
    }

    override func bindToViewModel() {
        let searchTextDriver = tfSearch.rx.text.asDriver()
        let input = BeerSearchVM.Input(searchText: searchTextDriver)
        let output = viewModel.transform(input: input)
        

        output.beers
            .drive(tvBeers.rx.items(cellIdentifier: BeerCell.identifier, cellType: BeerCell.self)) { _, beer, cell in
                cell.configure(with: beer)
            }.disposed(by: disposeBag)
        
        output.isLoading
            .asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { self.showLoading($0) })
            .disposed(by: disposeBag)
        
    }
    
    func setupTableView() {
        tvBeers.registerCell(cellType: BeerCell.self)
        tvBeers.rowHeight = UITableView.automaticDimension
    }
  
}
