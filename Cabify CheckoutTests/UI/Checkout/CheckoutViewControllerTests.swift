//
//  CheckoutViewControllerTests.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 8/1/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import XCTest
@testable import Cabify_Checkout

class CheckoutViewControllerTests: XCTestCase {

    var controller: CheckoutViewController!
    var presenterMock: CheckoutMocks.Presenter!
    var routerMock: CheckoutMocks.Router!
    var fixture: CheckoutFixture!
    
    override func setUp() {
        controller = UIStoryboard.Scene.Products.checkout;
        presenterMock = CheckoutMocks.Presenter(view: controller, cart: ProductCart());
        controller.presenter = presenterMock;
        routerMock = CheckoutMocks.Router(view: controller);
        controller.router = routerMock;
        fixture = CheckoutFixture();
    }

    override func tearDown() {
        controller = nil;
        presenterMock = nil;
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
    
    func testDisplayCartItems() {
        
        // When: controller loads view
        let tableSpy = CheckoutMocks.TableView(frame: CGRect.zero);
        let _ = controller.view;
        controller.tableView = tableSpy;
        
        // Then: tell controller to display a list of cart items.
        let cartItems = fixture.cartItems;
        controller.displayCartItems(cartItems);
        
        // Expect: tableView should display the products
        XCTAssertTrue(tableSpy.reloadDataCalled);
        XCTAssertEqual(2, controller.tableView(tableSpy, numberOfRowsInSection: 0));
        
    }

}
