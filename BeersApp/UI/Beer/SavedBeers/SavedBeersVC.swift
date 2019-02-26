//
//  SavedBeersVC.swift
//  BeersApp
//
//  Created by Marijan on 25/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class SavedBeersVC: MenuChildViewController<SavedBeersVM>, UITableViewDelegate {

    @IBOutlet weak var tvBeers: UITableView!
    @IBOutlet weak var lNoResults: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Saved Beers"
        setupTableView()
    }
    
    override func bindToViewModel() {
        let deletedDriver = tvBeers.rx.modelDeleted(Beer.self).asDriver()
        
        let input = SavedBeersVM.Input(itemDeleted: deletedDriver)
        let output = viewModel.transform(input: input)
        
        output.beersSection
            .drive(tvBeers.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.deleteResult
            .drive(onNext: { [unowned self] event in
                if !event.isError {
                    self.showMessage(event.message)
                } else {
                    self.showErrorMessage(event.message)
                }
            }).disposed(by: disposeBag)
        
        output.beerCount
            .drive(onNext: { [unowned self] count in
                self.showEmptyResultSetMessage(count == 0)
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
        tvBeers.rowHeight = 60
        
        tvBeers.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<BeerSection> {
        let dataSource = RxTableViewSectionedAnimatedDataSource<BeerSection>(configureCell: { (_, tv, ip, beer) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(cellType: BeerCell.self, for: ip)!
            cell.configure(with: beer)
            return cell
        })
        
        dataSource.animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                                   reloadAnimation: .automatic,
                                                                   deleteAnimation: .automatic)
        dataSource.canEditRowAtIndexPath = { _, _ in true }
        
        return dataSource
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.tvBeers.notifyEditAction(action: .delete, forRowAt: indexPath)
        }
        
        return [action]
    }
    
}

