//
//  AppDelegate.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit
import Swinject
import MMDrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    // MARK: - Properties
    
    var window: UIWindow?
    
    var drawerController: MMDrawerController!
    
    let container: Container = {
       return UIContainer.container
    }()


    
    // MARK: - AppDelegate Events
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        configureAppearance();
        
        // configure root view controller
        if NSClassFromString("XCTestCase") == nil {
            configureRootController();
        }
        
        return true;
    }
    
    
    
    // MARK: - UI Configuration
    
    /**
     Creates and configures the controller to be presented at launch.
     -> DrawerController [
        left: nil
        center: NavigationController -> ProductListController
        right: CartController
     ]
     */
    func configureRootController() {
        
        // Instantiate a window.
        let window = UIWindow(frame: UIScreen.main.bounds);
        window.makeKeyAndVisible();
        self.window = window;
        
        // Instantiate ProductList and Cart controller
        guard let productListController = container.resolve(ProductListViewController.self) else {
            fatalError("Unable to instantiate ProductList controller");
        }
        
        guard let cartController = container.resolve(CartViewController.self) else {
            fatalError("Unable to instantiate Cart controller");
        }
        
        // Embed in a navigation controller
        let navigationController = UINavigationController(rootViewController: productListController);
        
        // Create Drawer controller
        drawerController = MMDrawerController(center: navigationController, rightDrawerViewController: cartController);
        
        // Set as root view controller
        window.rootViewController = drawerController;
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

