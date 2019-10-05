//
//  AppDelegate.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/2/2.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase
import FacebookCore

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        GADMobileAds.sharedInstance().start(completionHandler: nil)

        return true
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
         return ApplicationDelegate.shared.application(
           application,
           open: url,
           sourceApplication: sourceApplication,
           annotation: annotation
         )
       }
       @available(iOS 9.0, *)
       func application(_ application: UIApplication,
                        open url: URL,
                        options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
         return ApplicationDelegate.shared.application(application, open: url, options: options)
       }

       func applicationDidBecomeActive(_ application: UIApplication) {
         AppEvents.activateApp()
       }

}

