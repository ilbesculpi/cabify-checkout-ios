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
    var fixture: CartFixture!
    
    override func setUp() {
        controller = UIStoryboard.Scene.Products.cart;
        presenterMock = CartMocks.Presenter(view: controller, cart: ProductCart());
        controller.presenter = presenterMock;
        fixture = CartFixture();
    }

    override func tearDown() {
        controller = nil;
        presenterMock = nil;
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
        controller.displayProducts(cartItems)
        
        // Expect: tableView should display the products
        XCTAssertTrue(tableSpy.reloadDataCalled);
        XCTAssertEqual(2, controller.tableView(tableSpy, numberOfRowsInSection: 0));
        
    }

}
