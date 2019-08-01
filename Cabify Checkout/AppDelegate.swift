//
//  AppDelegate.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit
import Swinject
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    // MARK: - Properties
    
    var window: UIWindow?
    
    var container: Container!
    
    var cartService: CartRepository!
    
    var shoppingCart: ProductCart {
        return container.resolve(ProductCart.self)!
    }
    
    
    // MARK: - AppDelegate Events
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // print environment config
        print("[INFO] Environment: \(Environment.environment)");
        
        // Bootstrap app
        if CommandLine.arguments.contains("enable-testing") || Environment.environment == "development" {
            setupContainer(testing: true)
        }
        else {
            setupContainer(testing: false);
        }
        
        
        // Ask the container to provide service dependencies
        cartService = container.resolve(CartRepository.self);
        
        return true;
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        
        // skip for Unit Testing
        if NSClassFromString("XCTestCase") == nil {
            boostrap(testing: true)
        }
        else {
            boostrap(testing: false)
        }
        
        return true;
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        cartService.saveCart(shoppingCart).always {}
    }
    
    
    // MARK: - Bootstrap
    
    func setupContainer(testing: Bool = false) {
        
        // Configure container
        if testing {
            // Use dummy container for testing
            container = UIContainer.dummy;
        }
        else {
            // Use default container
            container = UIContainer.app;
        }
        
    }
    
    func boostrap(testing: Bool = false) {
        configureAppearance();
        if !testing {
            // avoid loading promotions for testing
            configureShoppingCart();
        }
        
        if NSClassFromString("XCTestCase") == nil {
            // avoid loading the root view controller for testing
            configureRootController();
        }
    }
    
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
        
        // Instantiate RootViewController
        guard let rootController = container.resolve(RootViewController.self) else {
            fatalError("Unable to instantiate RootViewController");
        }
        
        // Set as root view controller
        window.rootViewController = rootController;
    }
    
    
    /**
     Load the stored promotions and setup default shopping cart
     */
    func configureShoppingCart() {
        cartService.loadPromotions()
            .then { [unowned self] (promotions) in
                self.cartService.loadCart(into: self.shoppingCart)
                    .then { (cart) in
                        cart.addPromotions(promotions);
                        cart.update();
                    }
            }
    }
    
    
    // MARK: - Appearance
    
    /**
     Defines the global appearance for some UI Components.
     */
    func configureAppearance() {
        
        configureNavigationBarAppearance();
        configureTabBarAppearance();
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
        UINavigationBar.appearance().barTintColor = UIColor(named: "PrimaryDark");
        
    }
    
    private func configureTabBarAppearance() {
        
        // Controls Color
        UITabBar.appearance().tintColor = UIColor(named: "PrimaryLight");
        
        // Bar Color
        UITabBar.appearance().barTintColor = UIColor.white;
        
    }


    
    // MARK: - CoreData Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CabifyCheckout");
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                print("[ERROR] CoreData unresolved error \(error), \(error.userInfo)");
            }
        }
        
        return container;
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext;
        if context.hasChanges {
            do {
                try context.save()
            }
            catch {
                let nserror = error as NSError
                print("[ERROR] CoreData error saving context: \(nserror), \(nserror.userInfo)");
            }
        }
    }
    
}

