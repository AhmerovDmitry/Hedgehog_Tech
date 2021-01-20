//
//  AppDelegate.swift
//  Hedgehog Tech
//
//  Created by Дмитрий Ахмеров on 20.01.2021.
//

import UIKit

@main
@available(iOS 13.0, *)
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabBarController = CustomTabBarController()
        tabBarController.viewControllers = tabBarController.controllers
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        self.window = window
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        return true
    }
}
