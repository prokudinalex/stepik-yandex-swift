//
//  AppDelegate.swift
//  Notes
//
//  Created by Alex Prokudin on 03/07/2019.
//  Copyright © 2019 Alex Prokudin. All rights reserved.
//

import UIKit
import CocoaLumberjack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func getVersionHello() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "VERSION_HELLO") as! String
    }
    
    func setupLogger() {
        // use console output
        DDLog.add(DDOSLogger.sharedInstance)
        
        // TODO: add more loggers like DDFileLogger in the future implementation
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupLogger()
        DDLogInfo(getVersionHello())
        return true
    }
}

