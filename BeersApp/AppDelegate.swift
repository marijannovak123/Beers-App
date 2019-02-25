//
//  AppDelegate.swift
//  BeersApp
//
//  Created by Marijan on 23/02/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit
import Swinject
import AlamofireNetworkActivityLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var instance: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var window: UIWindow?

    private(set) var singletonContainer: Container!
    private(set) var viewModelContainer: Container!
    private(set) var viewControllerContainer: Container!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        createDependencyContainers()
        logNetwork()
        resolveRootView()
        
        return true
    }
    
    func resolveRootView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewControllerContainer.resolve(SWRevealVC<MenuVC>.self)!
        window?.makeKeyAndVisible()
    }
    
    func createDependencyContainers() {
        singletonContainer = SingletonContainer.build()
        viewModelContainer = ViewModelContainer.build(singletonContainer: singletonContainer)
        viewControllerContainer = ViewControllerContainer.build(viewModelContainer: viewModelContainer)
    }
    
    func logNetwork() {
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
      
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
      
    }

}

