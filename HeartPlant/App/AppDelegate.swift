//
//  AppDelegate.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-20.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainTabBarController: MainTabBarController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let mainTabBarController = MainTabBarController()
        
        window.rootViewController = mainTabBarController
        window.makeKeyAndVisible()
        
        self.window = window
        self.mainTabBarController = mainTabBarController
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        guard let mainTabBarController = mainTabBarController else { return }
        mainTabBarController.shouldSaveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        guard let mainTabBarController = mainTabBarController else { return }
        mainTabBarController.shouldSaveContext()
    }
}

