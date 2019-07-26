//
//  AppDelegate.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureRootController();
        return true;
    }

    func configureRootController() {
        
        // Instantiate ProductList controller
        let storyboard = UIStoryboard.init(name: "Products", bundle: nil);
        let productListController = storyboard.instantiateViewController(withIdentifier: "ProductList");
        
        // Embed in a navigation controller
        let navigationController = UINavigationController(rootViewController: productListController);
        
        // Set as root view controller
        window = UIWindow(frame: UIScreen.main.bounds);
        window?.rootViewController = navigationController;
        window?.makeKeyAndVisible();
    }


}

