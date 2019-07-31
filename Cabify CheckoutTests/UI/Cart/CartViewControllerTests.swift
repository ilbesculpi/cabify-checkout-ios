//
//  CartViewControllerTests.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/31/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import XCTest
@testable import Cabify_Checkout

class CartViewControllerTests: XCTestCase {

    var controller: CartViewController!
    var presenterMock: CartMocks.Presenter!
    var routerMock: CartMocks.Router!
    var cartServiceMock: CartMocks.CartService!
    var fixture: CartFixture!
    
    override func setUp() {
        controller = UIStoryboard.Scene.Products.cart;
        presenterMock = CartMocks.Presenter(view: controller, cart: ProductCart());
        cartServiceMock = CartMocks.CartService();
        presenterMock.cartService = cartServiceMock;
        controller.presenter = presenterMock;
        routerMock = CartMocks.Router(view: controller);
        controller.router = routerMock;
        fixture = CartFixture();
    }

    override func tearDown() {
        controller = nil;
        presenterMock = nil;
        cartServiceMock = nil;
        routerMock = nil;
        fixture = nil;
    }
    
    func testOutlets() {
        
        // When: controller loads view
        let _ = controller.view;
        
        // Expect: table outlets should be created
        XCTAssertNotNil(controller.tableView);
        XCTAssertNotNil(controller.tableView.dataSource);
        XCTAssertNotNil(controller.tableView.delegate);
        XCTAssertFalse(controller.tableView.allowsSelection);
    }
    
    func testLoadView() {
        
        // When: controller loads view
        let _ = controller.view;
        
        // Expect: should call presenter onViewCreated
        XCTAssertTrue(presenterMock.onViewCreatedCalled, "controller should call presenter::onViewCreated()");
    }
    
    func testDisplayProducts() {
        
        // When: controller loads view
        let tableSpy = ProductListMocks.TableView(frame: CGRect.zero);
        let _ = controller.view;
        controller.tableView = tableSpy;
        
        // Then: tell controller to display a list of cart items.
        let cartItems = fixture.cartItems;
        controller.displayProducts(cartItems);
        
        // Expect: tableView should display the products
        XCTAssertTrue(tableSpy.reloadDataCalled);
        XCTAssertEqual(2, controller.tableView(tableSpy, numberOfRowsInSection: 0));
        
    }
    
    func testProceedToCheckout() {
        
        // When: controller loads view
        let _ = controller.view;
        
        // Then: tap on "Proceed to checkout" button
        controller.buttonProceedToCheckout.sendActions(for: .touchUpInside);
        
        // Expect: navigate to reset password screen
        XCTAssertTrue(routerMock.displayCheckoutScreenCalled, "should ask router to display Checkout screen");
        
    }

}
