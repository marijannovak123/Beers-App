//
//  BeerCell.swift
//  BeersApp
//
//  Created by Marijan on 24/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift


class BeerCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var ivBeerImage: UIImageView!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var expandableView: UIView!
    @IBOutlet weak var btnExpand: UIButton!
    @IBOutlet weak var lDescription: UILabel!
    
    private weak var delegate: CellExpandDelegate?
    private var index = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutMargins = UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)

    }
    
    func configure(with data: Beer) {
        lName.text = data.name
        ivBeerImage.sd_setImage(with: URL(string: data.labels?.icon ?? ""), placeholderImage: #imageLiteral(resourceName: "beer_placeholder"))
        lDescription.text = "kita"//data.description ?? "Some text"
    }
    
    func configureWithHandler(data: BeerWrapper, delegate: CellExpandDelegate) {
        self.btnExpand.isHidden = false
        self.delegate = delegate
        self.index = data.index
        
        configure(with: data.beer)
        
        btnExpand.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onExpand)))
        
        expandableView.isHidden = !data.isExpanded
        
        if data.isExpanded {
            btnExpand.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //Do nothing
    }
    
    @objc func onExpand() {
        let index = expandableView.isHidden ? self.index : -1
        delegate?.onExpanded(at: index)
    }
}
