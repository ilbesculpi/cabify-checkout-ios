//
//  AppDelegateTests.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import XCTest
import MMDrawerController
@testable import Cabify_Checkout

class AppDelegateTests: XCTestCase {
    
    var appDelegate: AppDelegate!

    override func setUp() {
        appDelegate = AppDelegate();
    }

    override func tearDown() {
        appDelegate = nil;
    }

    func testConfigureRootController() {
        
        // When: application launches
        
        // Expect: window should not exist
        XCTAssertNil(appDelegate.window);
        
        // Then: call configureRootController()
        appDelegate.configureRootController();
        
        // Expect: window should be created
        XCTAssertNotNil(appDelegate.window);
        
        // Expect: root controller should be created
        XCTAssertNotNil(appDelegate.window?.rootViewController, "rootViewController should be created");
        guard let rootViewController = appDelegate.window?.rootViewController as? MMDrawerController else {
            XCTFail("rootViewController should be a MMDrawerController");
            return;
        }
        
        if let centerController = rootViewController.centerViewController as? UINavigationController {
            XCTAssertNotNil(centerController.viewControllers.first);
            XCTAssertTrue(centerController.viewControllers.first is ProductListViewController, "first controller should be a ProductListController");
        }
        else {
            XCTFail("centerController should be a UINavigationController");
        }
        
        XCTAssertNotNil(rootViewController.rightDrawerViewController);
        XCTAssertTrue(rootViewController.rightDrawerViewController is CartViewController, "right controller should be a CartViewController");
        
    }
    
    func testConfigureAppearance() {
        
        // When: application launches
        
        // Then: call configureAppearance()
        appDelegate.configureAppearance();
        
        // Expect: navigation bar global appearance should be set
        XCTAssertEqual(UIColor.white, UINavigationBar.appearance().tintColor);
        XCTAssertEqual(UIColor.Scheme.primaryDark, UINavigationBar.appearance().barTintColor);
        
    }
    
}
