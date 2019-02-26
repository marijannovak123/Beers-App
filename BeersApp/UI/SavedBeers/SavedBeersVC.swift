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

class SavedBeersVC: MenuChildViewController<SavedBeersVM> {

    @IBOutlet weak var tvBeers: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Saved Beers"
        setupTableView()
    }
    
    override func bindToViewModel() {
        let input = SavedBeersVM.Input(itemDeleted: tvBeers.rx.modelDeleted(Beer.self).asDriver())
        let output = viewModel.transform(input: input)
        
        output.beersSection
            .drive(tvBeers.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.deleteResult
            .drive(onNext: { message, isSuccessful in
                if isSuccessful {
                    self.showMessage(message)
                } else {
                    self.showErrorMessage(message)
                }
            }).disposed(by: disposeBag)
        
    }

}

extension SavedBeersVC: UITableViewDelegate {
    
    func setupTableView() {
        tvBeers.registerCell(cellType: BeerCell.self)
        tvBeers.rowHeight = UITableView.automaticDimension
        
        tvBeers.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<BeerSection> {
        let dataSource = RxTableViewSectionedAnimatedDataSource<BeerSection>(configureCell: { (_, tv, ip, beer) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(cellType: BeerCell.self, for: ip)!
            cell.configure(with: beer)
            return cell
        })
        
        dataSource.animationConfiguration = AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
        dataSource.canEditRowAtIndexPath = { _, _ in true }
        return dataSource
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.tvBeers.notifyEditAction(action: .delete, forRowAt: indexPath)
        }
        
        return [action]
    }
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { action, view, handler in
//            self.tvBeers.deleteRows(at: [indexPath], with: .automatic)
//            //handler(true)
//        }
//
//        deleteAction.backgroundColor = .red
//
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
    
}
