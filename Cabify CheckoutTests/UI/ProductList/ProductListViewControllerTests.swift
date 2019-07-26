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

    override func setUp() {
        controller = UIStoryboard.Scene.Products.productList;
        presenterMock = ProductListMocks.Presenter(view: controller);
        controller.presenter = presenterMock;
    }

    override func tearDown() {
        controller = nil;
        presenterMock = nil;
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

}
