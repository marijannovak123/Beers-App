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
    
    private var deleteAllButton = UIBarButtonItem(image: #imageLiteral(resourceName: "delete-all"), style: .plain, target: nil, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "saved_beers".localized
        setupTableView()
        navigationItem.rightBarButtonItem = deleteAllButton
    }
    
    override func bindToViewModel() {
        let deletedDriver = tvBeers.rx.modelDeleted(BeerWrapper.self).asDriver()
        let allDeletedDriver = deleteAllButton.rx.tap.asDriver()
        let input = SavedBeersVM.Input(itemDeleted: deletedDriver, allDeleted: allDeletedDriver)
        let output = viewModel.transform(input: input)
        
        output.beersSection
            .drive(tvBeers.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.deleteResult
            .drive(onNext: { [unowned self] event in
                self.handleUIResult(event)
            }).disposed(by: disposeBag)
        
        output.deleteAllResult
            .drive(onNext: { [unowned self] event in
                self.handleUIResult(event)
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
        tvBeers.rowHeight = UITableView.automaticDimension
        tvBeers.estimatedRowHeight = 150
        
        tvBeers.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
   
    var dataSource: RxTableViewSectionedAnimatedDataSource<BeerSection> {
        let dataSource = RxTableViewSectionedAnimatedDataSource<BeerSection>(configureCell: { (_, tv, ip, beer) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(cellType: BeerCell.self, for: ip)!
            cell.configureWithHandler(data: beer, delegate: self)
            return cell
        })
        
        dataSource.animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                                   reloadAnimation: .automatic,
                                                                   deleteAnimation: .automatic)
        dataSource.canEditRowAtIndexPath = { _, _ in true }
        return dataSource
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .destructive, title: "delete".localized) { (action, indexPath) in
            DialogHelper.promptDialog(parent: self, message: "delete_prompt".localized, positiveText: "Yes", negativeText: "No", completion: {
                self.tvBeers.notifyEditAction(action: .delete, forRowAt: indexPath) //could have used Completable
            })
        }
        
        return [action]
    }
    
}

extension SavedBeersVC: CellExpandDelegate {
    
    func onExpanded(at index: Int) {
        viewModel.setExpandedCell(at: index)
    }
    
}
