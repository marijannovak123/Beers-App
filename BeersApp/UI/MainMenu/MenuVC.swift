//
//  MenuVC.swift
//  BeersApp
//
//  Created by Marijan on 25/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, MenuType {

    var items: [MenuItem]
    var viewControllers: [UIViewController]
    
    @IBOutlet weak var tvMenu: UITableView!
    
    weak var delegate: MenuDelegate?
    
    init(items: [MenuItem]) {
        self.items = items
        
        viewControllers = items.compactMap { $0.screen?.getController() }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        tvMenu.delegate = self
        tvMenu.dataSource = self
        tvMenu.registerCell(cellType: MenuItemCell.self)
    }
    
    func dismissMenu(animated: Bool) {
        viewControllers.forEach { $0.dismiss(animated: animated) }
        self.dismiss(animated: animated)
    }
    
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.showController(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MenuItemCell.self, for: indexPath)
        cell?.configure(with: items[indexPath.row])
        return cell ?? MenuItemCell()
    }
    
}

