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
import RxDataSources

class BeerSearchVC: MenuChildViewController<BeerSearchVM> {

    @IBOutlet weak var tvBeers: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    
    private lazy var dataSource = createDataSource()
    
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
            .map { [SectionModel(model: "Beers", items: $0)] }
            .drive(tvBeers.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
        
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
    
    func createDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, Beer>> {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Beer>>(configureCell: { _, tv, ip, beer in
            let cell = tv.dequeueReusableCell(cellType: BeerCell.self, for: ip)!
            cell.configure(with: beer)
            return cell
        })
        
        dataSource.canEditRowAtIndexPath = { _, _ in true }
        dataSource.canMoveRowAtIndexPath = { _, _ in true }
        return dataSource
    }
}

