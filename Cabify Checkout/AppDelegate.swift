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

    
    // MARK: - Properties
    
    var window: UIWindow?
    
    var container: Container = {
       return UIContainer.container
    }();

    
    // MARK: - AppDelegate Events
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        configureAppearance();
        configureShoppingCart();
        
        // configure root view controller
        if NSClassFromString("XCTestCase") == nil {
            configureRootController();
        }
        
        return true;
    }
    
    
    
    // MARK: - UI Configuration
    
    /**
     Creates and configures the controller to be presented at launch.
     -> UITabBarController [
        [0] -> UINavigationController -> ProductListController
        [1] -> UINavigationController -> CartController
     ]
     */
    func configureRootController() {
        
        // Instantiate a window.
        let window = UIWindow(frame: UIScreen.main.bounds);
        window.makeKeyAndVisible();
        self.window = window;
        
        // Instantiate RootController
        guard let rootController = container.resolve(UITabBarController.self) else {
            fatalError("Unable to instantiate Root controller");
        }
        
        // Set as root view controller
        window.rootViewController = rootController;
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
    
    
    // MARK: - App Configuration
    
    /**
     Load the stored promotions and setup default shopping cart
     */
    func configureShoppingCart() {
        let service = container.resolve(CartRepository.self);
        service?.loadPromotions()
            .then { (promotions) in
                CartService.defaultCart.addPromotions(promotions);
        }
    }


}

