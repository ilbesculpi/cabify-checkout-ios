//
//  AppDelegateTests.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import XCTest
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
        guard let rootViewController = appDelegate.window?.rootViewController as? UINavigationController else {
            XCTFail("rootViewController should be a UINavigationController");
            return;
        }
        XCTAssertNotNil(rootViewController.viewControllers.first);
        XCTAssertTrue(rootViewController.viewControllers.first is ProductListViewController, "first controller should be a ProductListController");
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
