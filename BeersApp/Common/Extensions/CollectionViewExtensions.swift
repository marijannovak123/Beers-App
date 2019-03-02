//
//  CollectionViewExtensions.swift
//  BeersApp
//
//  Created by Marijan on 01/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerCell<T: ReusableCollectionCell>(cellType: T.Type) {
        self.register(UINib(nibName: cellType.identifier, bundle: nil), forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeueReusableCell<T: ReusableCollectionCell>(cellType: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T
    }
    
}
