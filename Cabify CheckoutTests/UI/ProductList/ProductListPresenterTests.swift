//
//  ProductListPresenterTests.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/31/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import XCTest
@testable import Cabify_Checkout

class ProductListPresenterTests: XCTestCase {

    var presenter: ProductListPresenter!
    var controllerMock: ProductListMocks.ViewController!
    var productServiceMock: ProductListMocks.ProductService!
    var cart = ProductCart();
    var fixture: ProductListFixture!
    
    override func setUp() {
        controllerMock = ProductListMocks.ViewController();
        productServiceMock = ProductListMocks.ProductService();
        presenter = ProductListPresenter(view: controllerMock, cart: cart);
        presenter.productRepository = productServiceMock;
        fixture = ProductListFixture();
    }

    override func tearDown() {
        presenter = nil;
        controllerMock = nil;
    }

    func testOnViewCreatedShouldFetchProductList() {
        
        // When: load view call onViewCreated()
        presenter.onViewCreated();
        
        // Expect: 
        XCTAssertTrue(productServiceMock.fetchProductsCalled);
        
    }
    
    func testShouldNotifyViewToDisplayProducts() {
        
        // When:
        let products = fixture.productList;
        productServiceMock.returnProducts(products);
        
        // Then: call fetchProducts()
        presenter.fetchProducts();
        
        // Expect
        let expectation = self.expectation(description: "fetchProductsAsync");
        XCTAssertTrue(controllerMock.displayProductsCalled, "presenter should call displayProducts");
        XCTAssertEqual(products, controllerMock.products);
        
        // Wait for the expectation to be fullfilled
        waitForExpectations(timeout: 3, handler: nil);
    }

}
