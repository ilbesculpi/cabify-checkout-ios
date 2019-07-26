//
//  ProductListViewControllerTests.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import XCTest
@testable import Cabify_Checkout

class ProductListViewControllerTests: XCTestCase {
    
    var controller: ProductListViewController!
    var presenterMock: ProductListMocks.Presenter!
    var fixture: ProductListFixture!

    override func setUp() {
        controller = UIStoryboard.Scene.Products.productList;
        presenterMock = ProductListMocks.Presenter(view: controller);
        controller.presenter = presenterMock;
        fixture = ProductListFixture();
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
    }

    func testLoadView() {
        
        // When: controller loads view
        let _ = controller.view;
        
        // Expect: should call presenter onViewCreated
        XCTAssertTrue(presenterMock.onViewCreatedCalled, "controller should call presenter::onViewCreated()");
    }
    
    func testDisplayProducts() {
        
        // When: controller loads view
        let tableSpy = ProductListMocks.TableView(frame: CGRect.zero)
        let _ = controller.view;
        controller.tableView = tableSpy;
        
        // Then: tell controller to display a list of products
        let products = fixture.productList;
        controller.displayProducts(products);
        
        // Expect: tableView should display the products
        XCTAssertTrue(tableSpy.reloadDataCalled);
        XCTAssertEqual(3, controller.tableView(tableSpy, numberOfRowsInSection: 0));
    }

}
