//
//  ProductCartTests.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/27/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import XCTest
@testable import Cabify_Checkout

class ProductCartTests: XCTestCase {

    var cart: ProductCart!
    var fixture: ProductCartFixture = ProductCartFixture();
    
    override func setUp() {
        cart = ProductCart();
    }

    override func tearDown() {
        cart = nil;
    }

    func testEmptyCart() {
        
        // When: cart is empty
        
        // Expect:
        XCTAssertTrue(cart.isEmpty, "cart should be empty");
        XCTAssertEqual(0, cart.itemCount, "empty cart should have 0 items");
        XCTAssertEqual(0, cart.discount, "empty cart should have discount = 0.00");
        XCTAssertEqual(0, cart.total, "empty cart should have total = 0.00");
        
    }
    
    func testAddSingleProduct() {
        
        // When: cart is empty
        
        // Then: add item MUG
        let product = fixture.getProduct(code: "MUG")!
        cart.addProduct(product);
        
        // Expect: 1x7.5 = 7.50
        XCTAssertFalse(cart.isEmpty, "cart should not be empty");
        XCTAssertEqual(1, cart.itemCount, "cart should have 1 item");
        XCTAssertEqual(0, cart.discount, "discount should be 0.00");
        XCTAssertEqual(7.5, cart.total, "total should be 7.50");
        
    }
    
    func testAddTwoProducts() {
        
        // When: cart is empty
        
        // Then: add item MUG
        var product = fixture.getProduct(code: "MUG")!
        cart.addProduct(product);
        
        // Expect: 1x7.5 = 7.50
        XCTAssertEqual(1, cart.itemCount, "cart should have 1 item");
        XCTAssertEqual(0, cart.discount, "discount should be 0.00");
        XCTAssertEqual(7.5, cart.total, "total should be 7.50");
        
        // Then: add item VOUCHER
        product = fixture.getProduct(code: "VOUCHER")!
        cart.addProduct(product);
        
        // Expect: (1x7.5) + (1x5.0) = 12.50
        XCTAssertEqual(2, cart.itemCount, "cart should have 2 items");
        XCTAssertEqual(0, cart.discount, "discount should be 0.00");
        XCTAssertEqual(12.5, cart.total, "total should be 12.50");
    }
    
    func testAddMultipleProducts() {
        
        // When: cart is empty
        
        // Then: add item MUG
        let mug = fixture.getProduct(code: "MUG")!
        let voucher = fixture.getProduct(code: "VOUCHER")!
        let tshirt = fixture.getProduct(code: "TSHIRT")!
        
        cart.addProduct(mug);
        cart.addProduct(voucher);
        cart.addProduct(tshirt);
        cart.addProduct(mug);
        cart.addProduct(tshirt);
        cart.addProduct(tshirt);
        
        // Expect: (2x7.5) + (1x5.0) + (3x20.0) = 80.0
        XCTAssertEqual(6, cart.itemCount, "cart should have 3 items");
        XCTAssertEqual(0, cart.discount, "discount should be 0.00");
        XCTAssertEqual(80.0, cart.total, "total should be 22.50");
        
        
    }
    

}
