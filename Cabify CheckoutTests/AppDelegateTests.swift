//
//  AppDelegateTests.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import XCTest
import Swinject
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
        
        let containerMock = Container();
        let tabControllerSpy = UITabBarController();
        containerMock.register(UITabBarController.self) { r in
            return tabControllerSpy;
        }
        appDelegate.container = containerMock;
        
        // When: application launches
        
        // Expect: window should not exist
        XCTAssertNil(appDelegate.window);
        
        // Then: call configureRootController()
        appDelegate.configureRootController();
        
        // Expect: window should be created
        XCTAssertNotNil(appDelegate.window);
        
        // Expect: appDelegate should ask UIContainer to provide a UITabBarController
        XCTAssertNotNil(appDelegate.window?.rootViewController, "rootViewController should be created");
        XCTAssertEqual(appDelegate.window?.rootViewController, tabControllerSpy);
        
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
