//
//  AppDelegate.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let container: Container = {
       return UIContainer.container
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        configureAppearance();
        
        // configure root view controller
        if NSClassFromString("XCTestCase") == nil {
            configureRootController();
        }
        
        return true;
    }
    
    
    /**
     Creates and configures the controller to be presented at launch.
     */
    func configureRootController() {
        
        // Instantiate a window.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        // Instantiate ProductList controller
        guard let productListController = container.resolve(ProductListViewController.self) else {
            fatalError("Unable to instantiate root view controller");
        }
        
        // Embed in a navigation controller
        let navigationController = UINavigationController(rootViewController: productListController);
        
        // Set as root view controller
        window.rootViewController = navigationController;
    }
    
    
    // MARK: - Appearance
    
    /**
     Defines the global appearance for some UI Components.
     */
    func configureAppearance() {
        
        configureNavigationBarAppearance();
        
    }
    
    private func configureNavigationBarAppearance()  {
        
        // Title Color
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ];
        
        // Controls Color
        UINavigationBar.appearance().tintColor = UIColor.white;
        
        // Bar Color
        UINavigationBar.appearance().barTintColor = UIColor.Scheme.primaryDark;
        
    }
    

    


}

