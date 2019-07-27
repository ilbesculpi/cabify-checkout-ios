//
//  ProductServiceTests.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/27/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import XCTest
@testable import Cabify_Checkout

class ProductServiceTests: XCTestCase {
    
    var service: ProductService!

    override func setUp() {
        service = ProductService();
    }

    override func tearDown() {
        service = nil;
    }

    func testFetchProducts() {
        
        let expectation = self.expectation(description: "Networking")
        
        service.fetchProducts()
            .then { (products) in
                
                // Expect:
                XCTAssertNotNil(products);
                XCTAssertEqual(3, products.count);
                
                expectation.fulfill();
            }
            .catch { (error) in
                XCTFail("Error thrown: \(error.localizedDescription)");
                expectation.fulfill();
            }
        
        // Wait for the expectation to be fullfilled
        waitForExpectations(timeout: 3, handler: nil)
        
    }


}
