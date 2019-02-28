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

class BeerSearchVC: MenuChildViewController<BeerSearchVM>, UITableViewDelegate {
    
    @IBOutlet weak var tvBeers: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var lNoResults: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "browse_beers".localized
        setupTableView()
    }
    
    override func bindToViewModel() {
        let searchTextDriver = tfSearch.rx.text.asDriver()
        
        let selectionDriver = tvBeers.rx.itemSelected
            .asDriver()
            .throttle(0.5)
        
        let saveSwipeDriver = tvBeers.rx.itemSwipedTrailing()
            .filter { event in
                event.actionName == "Save"
            }.asDriverOnErrorJustComplete()
        
        let input = BeerSearchVM.Input(
            searchText: searchTextDriver,
            selectionTrigger: selectionDriver,
            saveTrigger: saveSwipeDriver
        )
        
        let output = viewModel.transform(input: input)
        
        output.beersSection
            .drive(tvBeers.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
        
        output.isLoading
            .asObservable()
            .subscribe(onNext: { [unowned self] in
                self.showLoading($0)
            }).disposed(by: disposeBag)
        
       output.selectionResult
            .drive(onNext: { [unowned self] beer in
                if let beer = beer {
                    self.navigate(to: .beerDetails(beer: beer))
                }
            }).disposed(by: disposeBag)
        
        output.beerCount
            .drive(onNext: { [unowned self] count in
                self.showEmptyResultSetMessage(count == 0)
            }).disposed(by: disposeBag)
        
       output.saveResult
            .drive(onNext: { [unowned self] event in
                if !event.isError {
                    self.showMessage(event.message)
                } else {
                    self.showErrorMessage(event.message)
                }
            }).disposed(by: disposeBag)
        
    }
    
    func showEmptyResultSetMessage(_ show: Bool) {
        if show {
            tvBeers.isHidden = true
            lNoResults.isHidden = false
        } else {
            tvBeers.isHidden = false
            lNoResults.isHidden = true
        }
    }
    
    func setupTableView() {
        tvBeers.registerCell(cellType: BeerCell.self)
        tvBeers.rowHeight = UITableView.automaticDimension
        tvBeers.estimatedRowHeight = 150
        
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
        let saveAction = UIContextualAction(style: .normal, title: "save".localized) { action, view, handler in
            handler(true)
            self.tvBeers.notifyTrailingSwipe(action: "Save", indexPath: indexPath)
        }
        
        saveAction.backgroundColor = .green
        
        return UISwipeActionsConfiguration(actions: [saveAction])
    }

}

