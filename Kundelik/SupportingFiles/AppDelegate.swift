//
//  AppDelegate.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/16/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupNavigationBarAppearance()
        return true
    }
    
    func setupNavigationBarAppearance() {
        UINavigationBar.appearance().tintColor = Constants.Color.redColor
        
    }

}
