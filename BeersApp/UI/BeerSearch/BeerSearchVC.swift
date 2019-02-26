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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Browse Beers"
        setupTableView()
    }

    override func bindToViewModel() {
        let input = BeerSearchVM.Input(
            searchText: tfSearch.rx.text.asDriver()
        )
        
        let output = viewModel.transform(input: input)
        
        output.beersSection
            .drive(tvBeers.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
        
        output.isLoading
            .asObservable()
            .subscribe(onNext: { self.showLoading($0) })
            .disposed(by: disposeBag)
        
        let selectionDriver = tvBeers.rx.itemSelected
                                .asDriver()
                                .throttle(0.5)
      
        //TODO: Refactor this as input!!!
        Driver.combineLatest(selectionDriver, output.beers)
            .asObservable()
            .subscribe(onNext: { [unowned self] indexBeersJoin in
                let (indexPath, beers) = indexBeersJoin
                let beer = beers[indexPath.row]
                self.navigate(to: .beerDetails(beer: beer))
            }).disposed(by: disposeBag)
        
        let saveSwipeDriver = tvBeers.rx.itemSwipedTrailing()
            .filter { event in
                event.actionName == "Save"
            }.asDriverOnErrorJustComplete()
        
        Driver.combineLatest(saveSwipeDriver, output.beers)
            .asObservable()
            .flatMap { (parameters) -> Observable<Void> in
                let (swipeEvent, beers) = parameters
                let beer = beers[swipeEvent.indexPath.row]
                return self.viewModel.saveBeer(beer)
            }.subscribe(onNext: { _ in
                 self.showMessage("Beer successfully persisted to local storage!")
            }, onError: { _ in
                self.showErrorMessage("Error persisting beer.")
            }).disposed(by: disposeBag)
        
    }
    
}

extension BeerSearchVC: UITableViewDelegate {
    
    func setupTableView() {
        tvBeers.registerCell(cellType: BeerCell.self)
        tvBeers.rowHeight = UITableView.automaticDimension
        
        tvBeers.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, Beer>> {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Beer>>(configureCell: { _, tv, ip, beer in
            let cell = tv.dequeueReusableCell(cellType: BeerCell.self, for: ip)!
            cell.configure(with: beer)
            return cell
        })
        
        dataSource.canEditRowAtIndexPath = { _, _ in true }

        return dataSource
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let saveAction = UIContextualAction(style: .normal, title: "Save") { action, view, handler in
            handler(true)
            self.tvBeers.notifyTrailingSwipe(action: "Save", indexPath: indexPath)
        }
        
        saveAction.backgroundColor = .green
        
        return UISwipeActionsConfiguration(actions: [saveAction])
    }
    
}
