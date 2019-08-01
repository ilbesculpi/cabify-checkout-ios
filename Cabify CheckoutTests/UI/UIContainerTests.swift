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
        container = UIContainer.app;
    }

    override func tearDown() {
        container = nil;
    }
    
    func testRootControllerDependencies() {
        
        guard let tabController = container.resolve(RootViewController.self) else {
            XCTFail("Unable to instantiate RootViewController controller");
            return;
        }
        
        // Expect: tabController dependencies should be set
        XCTAssertNotNil(tabController.presenter);
        XCTAssertNotNil(tabController.presenter.cart);
        
        // Expect: tabController should have 2 tabs: [Browse, Cart]
        XCTAssertEqual(2, tabController.viewControllers!.count, "root controller should have 2 tabs");
        
        let tabBrowse = tabController.viewControllers![0];
        XCTAssertTrue(tabBrowse is UINavigationController);
        let navBrowse = tabBrowse as! UINavigationController
        XCTAssertTrue(navBrowse.viewControllers[0] is ProductListViewController);
        
        let tabCart = tabController.viewControllers![1];
        XCTAssertTrue(tabCart is UINavigationController);
        let navCart = tabCart as! UINavigationController;
        XCTAssertTrue(navCart.viewControllers[0] is CartViewController);
        
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
        XCTAssertNotNil(controller.presenter.cartService, "container should provide repository");
        
        XCTAssertNotNil(controller.router.view, "container should wire router's view");
        
    }
    
    func testProductListAndCartControllerShouldBeGivenTheSameProductCartInstance() {
        
        
        // When: asked container to provide ProductList and Cart controllers...
        guard let productListController = container.resolve(ProductListViewController.self),
            let cartController = container.resolve(ProductListViewController.self) else {
            XCTFail("Unable to instantiate ProductList and Cart controllers");
            return;
        }
        
        let productListCart = productListController.presenter.cart;
        let cartCart = cartController.presenter.cart;
        
        // Expect: both variables should be equals
        XCTAssertNotNil(productListController.presenter.cart);
        XCTAssertNotNil(cartController.presenter.cart);
        XCTAssertEqual(productListCart, cartCart, "cart instances should be the same");
        XCTAssertEqual(productListCart.itemCount, cartCart.itemCount);
        
        // Then: Add a product to productListCart
        let mug = ProductCartFixture().getProduct(code: "MUG")!
        productListCart.addProduct(mug);
        
        // Expect: both carts should contain the MUG
        XCTAssertEqual(cartCart.itemCount, productListCart.itemCount);
        
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
