//
//  BeerWebVC.swift
//  BeersApp
//
//  Created by UHP Mac on 21/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit
import WebKit

class BeerWebVC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var wvBrowser: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "beer_web".localized
        addMenuButton()
        wvBrowser.navigationDelegate = self
        wvBrowser.allowsBackForwardNavigationGestures = true

        let url = URL(string: "https://vinepair.com/beer-101/")!
        wvBrowser.load(URLRequest(url: url))
    }

    func addMenuButton() {
        self.revealViewController()?.tapGestureRecognizer()
        self.revealViewController()?.panGestureRecognizer().isEnabled = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(toggleReveal))
    }
    
    @objc private func toggleReveal() {
        self.revealViewController()?.revealToggle(animated: true)
    }

}
