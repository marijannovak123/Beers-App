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
    @IBOutlet weak var tvPersonalBeers: UITableView!
    @IBOutlet weak var lNoResults: UILabel!
    
    private var deleteAllButton = UIBarButtonItem(image: #imageLiteral(resourceName: "delete-all"), style: .plain, target: nil, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "saved_beers".localized
        setupTableViews()
        navigationItem.rightBarButtonItem = deleteAllButton
    }
    
    override func bindToViewModel() {
        let deletedDriver = tvBeers.rx.modelDeleted(BeerWrapper.self).asDriver()
        let allDeletedDriver = deleteAllButton.rx.tap.asDriver()
        let input = SavedBeersVM.Input(itemDeleted: deletedDriver, allDeleted: allDeletedDriver)
        let output = viewModel.transform(input: input)
        
        output.beersSection
            .drive(tvBeers.rx.items(dataSource: beerDataSource))
            .disposed(by: disposeBag)
        
        output.personalBeersSection
            .drive(tvPersonalBeers.rx.items(dataSource: personalBeerDataSource))
            .disposed(by: disposeBag)
        
        output.deleteResult
            .drive(onNext: { [unowned self] event in
                self.handleUIResult(event)
            }).disposed(by: disposeBag)
        
        output.deleteAllResult
            .drive(onNext: { [unowned self] event in
                self.handleUIResult(event)
            }).disposed(by: disposeBag)
        
        output.anyBeers
            .drive(onNext: { [unowned self] anyBeers in
                self.showEmptyResultSetMessage(!anyBeers)
            }).disposed(by: disposeBag)
    }
    
    func showEmptyResultSetMessage(_ show: Bool) {
        if show {
            tvBeers.isHidden = true
            tvPersonalBeers.isHidden = true
            lNoResults.isHidden = false
        } else {
            tvBeers.isHidden = false
            tvPersonalBeers.isHidden = false
            lNoResults.isHidden = true
        }
    }
    
    func setupTableViews() {
        tvBeers.registerCell(cellType: BeerCell.self)
        tvBeers.rowHeight = UITableView.automaticDimension
        tvBeers.estimatedRowHeight = 150
        
        tvBeers.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        tvPersonalBeers.registerCell(cellType: PersonalBeerCell.self)
        tvPersonalBeers.rowHeight = UITableView.automaticDimension
        tvPersonalBeers.estimatedRowHeight = 200
        
        tvPersonalBeers.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
   
    var beerDataSource: RxTableViewSectionedAnimatedDataSource<BeerSection> {
        let dataSource = RxTableViewSectionedAnimatedDataSource<BeerSection>(configureCell: { (_, tv, ip, beer) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(cellType: BeerCell.self, for: ip)!
            cell.configureWithHandler(data: beer, delegate: self)
            return cell
        })
        
        dataSource.titleForHeaderInSection = { _, _  in "Beers" }
        dataSource.canEditRowAtIndexPath = { _, _ in true }
        return dataSource
    }
    
    var personalBeerDataSource: RxTableViewSectionedAnimatedDataSource<PersonalBeerSection> {
        let dataSource = RxTableViewSectionedAnimatedDataSource<PersonalBeerSection>(configureCell: {
            (_, tv, ip, beer) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(cellType: PersonalBeerCell.self, for: ip)!
            cell.configure(with: beer)
            return cell
        })
        
        dataSource.titleForHeaderInSection = { _, _  in "Personal Beers" }

        return dataSource
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if tableView == tvBeers {
            let action = UITableViewRowAction(style: .destructive, title: "delete".localized) { (action, indexPath) in
                DialogHelper.promptDialog(parent: self, message: "delete_prompt".localized, positiveText: "Yes", negativeText: "No", completion: {
                    self.tvBeers.notifyEditAction(action: .delete, forRowAt: indexPath) 
                })
            }
            
            return [action]
        } else {
            return nil
        }
    }
    
}

extension SavedBeersVC: CellExpandDelegate {
    
    func onExpanded(at index: Int) {
        viewModel.setExpandedCell(at: index)
    }
    
}
