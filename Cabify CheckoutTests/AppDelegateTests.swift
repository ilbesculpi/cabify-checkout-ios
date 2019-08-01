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
        let tabControllerSpy = UIStoryboard.Scene.App.root;
        containerMock.register(RootViewController.self) { r in
            let cart = ProductCart();
            tabControllerSpy.presenter = RootPresenter(view: tabControllerSpy, cart: cart);
            let tab0 = UIViewController();
            let tab1 = UIViewController();
            tabControllerSpy.viewControllers = [tab0, tab1];
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
        
        // Expect: appDelegate should ask UIContainer to provide a RootViewController
        XCTAssertNotNil(appDelegate.window?.rootViewController, "rootViewController should be created");
        XCTAssertEqual(appDelegate.window?.rootViewController, tabControllerSpy);
        
    }
    
    func testConfigureAppearance() {
        
        // When: application launches
        
        // Then: call configureAppearance()
        appDelegate.configureAppearance();
        
        // Expect: navigation bar appearance should be set
        XCTAssertEqual(UIColor.white, UINavigationBar.appearance().tintColor);
        XCTAssertEqual(UIColor(named: "PrimaryDark"), UINavigationBar.appearance().barTintColor);
        
        // Expect: tab bar appearance should be set
        XCTAssertEqual(UIColor(named: "PrimaryLight"), UITabBar.appearance().tintColor);
        XCTAssertEqual(UIColor.white, UITabBar.appearance().barTintColor);
        
    }
    
    func testContainerSetupForTesting() {
        
        // When: application launches
        
        // Then: call setupContainer()
        appDelegate.setupContainer(testing: true);
        
        // Expect: container should be dummy
        XCTAssertNotNil(appDelegate.container);
        
        // Expect: ProductRepository should be DummyProductService
        let repository = appDelegate.container.resolve(ProductRepository.self)
        
        XCTAssertTrue(repository is DummyProductService, "container should provide DummyProductService");
    }
    
    func testContainerSetup() {
        
        // When: application launches
        
        // Then: call setupContainer()
        appDelegate.setupContainer();
        
        // Expect: container should be real
        XCTAssertNotNil(appDelegate.container);
        
        // Expect: ProductRepository should be DummyProductService
        let repository = appDelegate.container.resolve(ProductRepository.self)
        
        XCTAssertTrue(repository is ProductService, "container should provide ProductService");
    }
    
    
}
