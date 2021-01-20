//
//  CustomTabBarController.swift
//  Hedgehog Tech
//
//  Created by Дмитрий Ахмеров on 20.01.2021.
//

import UIKit

class CustomTabBarController: UITabBarController {
    let jokesVC = JokesViewController()
    let browserVC = BrowserViewController()
    
    var controllers: [UIViewController]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        
        controllers = [jokesVC, browserVC]
        
        tabBar.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .white
    }
    
    func setupItems() {
        jokesVC.tabBarItem.title = "Jokes"
        //jokesVC.tabBarItem.image = UIImage(systemName: "trash")
        
        browserVC.tabBarItem.title = "API"
        //browserVC.tabBarItem.image = UIImage(systemName: "user")
    }
}
