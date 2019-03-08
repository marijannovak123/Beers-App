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
        title = "Beer Game"
        addMenuButton()
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
        
        let scene = GameStartOrOverScene()
        scene.isGameOver = false
        scene.size = view.bounds.size
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }

    func addMenuButton() {
        self.revealViewController()?.tapGestureRecognizer()
        self.revealViewController()?.panGestureRecognizer().isEnabled = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(toggleReveal))
    }
    
    @objc private func toggleReveal() {
        self.revealViewController()?.revealToggle(animated: true)
    }
}
