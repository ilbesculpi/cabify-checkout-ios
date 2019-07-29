//
//  UIContainerTests.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/27/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import XCTest
import Swinject
@testable import Cabify_Checkout

class UIContainerTests: XCTestCase {

    var container: Container!
    
    override func setUp() {
        container = UIContainer.container;
    }

    override func tearDown() {
        container = nil;
    }

    func testProductListDependencies() {
        
        guard let controller = container.resolve(ProductListViewController.self) else {
            XCTFail("Unable to instantiate ProductList controller");
            return;
        }
        
        XCTAssertNotNil(controller.presenter, "container should provide a presenter");
        XCTAssertNotNil(controller.router, "container should provide a router");
        
        XCTAssertNotNil(controller.presenter.view, "container should wire presenter's view");
        XCTAssertNotNil(controller.presenter.productRepository, "container should provide a repository");
        XCTAssertNotNil(controller.presenter.cart, "container should provide a cart");
        
        XCTAssertNotNil(controller.router.view, "container should wire router's view");
        
    }
    
    func testCartViewController() {
        
        guard let controller = container.resolve(CartViewController.self) else {
            XCTFail("Unable to instantiate Cart controller");
            return;
        }
        
        XCTAssertNotNil(controller.presenter, "container should provide a presenter");
        XCTAssertNotNil(controller.router, "container should provide a router");
        
        XCTAssertNotNil(controller.presenter.view, "container should wire presenter's view");
        
        XCTAssertNotNil(controller.router.view, "container should wire router's view");
        
    }
    
    func testCheckoutController() {
        
        guard let controller = container.resolve(CheckoutViewController.self) else {
            XCTFail("Unable to instantiate Checkout controller");
            return;
        }
        
        XCTAssertNotNil(controller.presenter, "container should provide a presenter");
        XCTAssertNotNil(controller.router, "container should provide a router");
        
        XCTAssertNotNil(controller.presenter.view, "container should wire presenter's view");
        
        XCTAssertNotNil(controller.router.view, "container should wire router's view");
        
    }

}
