//
//  GameVC.swift
//  BeersApp
//
//  Created by Marijan on 07/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit
import SpriteKit

class GameVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        displayGameScene()
    }
    
    func displayGameScene() {
        let skView = SKView()
        skView.translatesAutoresizingMaskIntoConstraints = false
        skView.ignoresSiblingOrder = true
    
        view.addSubview(skView)
        
        skView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        skView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        skView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        let scene = BeerGameScene()
        scene.size = view.bounds.size
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }

}
