//
//  AppDelegate.swift
//  Notes
//
//  Created by Alex Prokudin on 03/07/2019.
//  Copyright © 2019 Alex Prokudin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func getVersionHello() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "VERSION_HELLO") as! String
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(getVersionHello())
        return true
    }
}

