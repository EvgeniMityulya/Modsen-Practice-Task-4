//
//  AppDelegate.swift
//  Police Race
//
//  Created by Евгений Митюля on 1.07.24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: MainMenuViewController())
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

