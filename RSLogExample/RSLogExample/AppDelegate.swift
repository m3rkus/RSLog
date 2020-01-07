//
//  AppDelegate.swift
//  RSLogExample
//
//  Created by Роман Анистратенко on 27/06/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit
import RSLog


// Shortcut for the log singleton
let log = RSLog.shared

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        log.info("This is an info message")
        log.debug("This is a debug message")
        log.error("This is an error message")
        
        return true
    }
}

