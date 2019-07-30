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
    let fixture: ProductCartFixture = ProductCartFixture();
    var VOUCHER: Product!
    var TSHIRT: Product!
    var MUG: Product!
    
    override func setUp() {
        cart = ProductCart();
        VOUCHER = fixture.getProduct(code: "VOUCHER")!
        TSHIRT = fixture.getProduct(code: "TSHIRT")!
        MUG = fixture.getProduct(code: "MUG")!
    }

    override func tearDown() {
        cart = nil;
    }

    func testNewCartShouldBeEmpty() {
        
        // When: cart is empty
        
        // Expect:
        XCTAssertTrue(cart.isEmpty, "cart should be empty");
        XCTAssertEqual(0, cart.itemCount, "empty cart should have 0 items");
        XCTAssertEqual(0, cart.discount, "empty cart should have discount = 0.00");
        XCTAssertEqual(0, cart.total, "empty cart should have total = 0.00");
        
    }
    
    func testEmptyCart() {
        
        // When: add items
        cart.addProduct(MUG, quantity: 2);
        
        // Then: call empty()
        XCTAssertFalse(cart.isEmpty);
        cart.empty();
        
        // Expect: cart should be empty
        XCTAssertTrue(cart.isEmpty);
        XCTAssertEqual(0, cart.itemCount);
        XCTAssertEqual(0, cart.total);
        XCTAssertEqual(0, cart.discount);
        
    }
    
    func testAddSingleProduct() {
        
        // When: cart is empty
        
        // Then: add item MUG
        cart.addProduct(MUG);
        
        // Expect: 1x7.5 = 7.50
        XCTAssertFalse(cart.isEmpty, "cart should not be empty");
        XCTAssertEqual(1, cart.itemCount, "cart should have 1 item");
        XCTAssertEqual(0, cart.discount, "discount should be 0.00");
        XCTAssertEqual(7.5, cart.total, "total should be 7.50");
        
    }
    
    func testAddTwoProducts() {
        
        // When: cart is empty
        
        // Then: add item MUG
        cart.addProduct(MUG);
        
        // Expect: 1x7.5 = 7.50
        XCTAssertEqual(1, cart.itemCount, "cart should have 1 item");
        XCTAssertEqual(0, cart.discount, "discount should be 0.00");
        XCTAssertEqual(7.5, cart.total, "total should be 7.50");
        
        // Then: add item VOUCHER
        cart.addProduct(VOUCHER);
        
        // Expect: (1x7.5) + (1x5.0) = 12.50
        XCTAssertEqual(2, cart.itemCount, "cart should have 2 items");
        XCTAssertEqual(0, cart.discount, "discount should be 0.00");
        XCTAssertEqual(12.5, cart.total, "total should be 12.50");
    }
    
    func testAddMultipleProducts() {
        
        // When: cart is empty
        
        // Then: add items MUG, VOUCHER, TSHIRT, MUG, TSHIRT, TSHIRT
        cart.addProduct(MUG);
        cart.addProduct(VOUCHER);
        cart.addProduct(TSHIRT);
        cart.addProduct(MUG);
        cart.addProduct(TSHIRT);
        cart.addProduct(TSHIRT);
        
        // Expect: (2x7.5) + (1x5.0) + (3x20.0) = 80.0
        XCTAssertEqual(6, cart.itemCount, "cart should have 3 items");
        XCTAssertEqual(0, cart.discount, "discount should be 0.00");
        XCTAssertEqual(80.0, cart.total, "total should be 22.50");
        
    }
    
    func testPromotion2x1() {
        
        // When: cart is empty 2x1 with discounts in MUG
        cart.addPromotion(code: "MUG", name: "MUG 2x1", type: .combo(quantity: 2, free: 1));
        
        // Then: add 1 MUG
        cart.addProduct(MUG);
        
        // Expect: (1x7.5) = 7.5
        XCTAssertEqual(1, cart.itemCount, "cart should have 1 item");
        XCTAssertEqual(0, cart.discount, "discount should be 0.00");
        XCTAssertEqual(7.5, cart.total, "total should be 7.5");
        
        // Then: add 1 MUG
        cart.addProduct(MUG);
        
        // Expect: Apply 2x1: [2x1](1x7.5) = 7.5
        XCTAssertEqual(2, cart.itemCount, "cart should have 2 items");
        XCTAssertEqual(7.5, cart.discount, "discount should be 7.5");
        XCTAssertEqual(7.5, cart.total, "total should be 7.5");
        
        // Then: add 1 MUG
        cart.addProduct(MUG);
        
        // Expect: Apply 2x1: [2x1](1x7.5) + (1x7.5) = 7.5
        XCTAssertEqual(3, cart.itemCount, "cart should have 3 items");
        XCTAssertEqual(7.5, cart.discount, "discount should be 7.5");
        XCTAssertEqual(15.0, cart.total, "total should be 15.0");
        
        // Then: add 1 MUG
        cart.addProduct(MUG);
        
        // Expect: Apply 2x1: [2x1](1x7.5) + [2x1](1x7.5) = 15.0
        XCTAssertEqual(4, cart.itemCount, "cart should have 4 items");
        XCTAssertEqual(15.0, cart.discount, "discount should be 15.0");
        XCTAssertEqual(15.0, cart.total, "total should be 15.0");
        
        // Then: add 1 MUG
        cart.addProduct(MUG);
        
        // Expect: Apply 2x1: [2x1](1x7.5) + [2x1](1x7.5) + (1x7.5) = 22.5
        XCTAssertEqual(5, cart.itemCount, "cart should have 5 items");
        XCTAssertEqual(15.0, cart.discount, "discount should be 15.00");
        XCTAssertEqual(22.5, cart.total, "total should be 22.50");
        
    }

    func testBulkPromotion() {
        
        // When: cart is empty with bulk discounts in VOUCHER
        cart.addPromotion(code: "VOUCHER", name: "VOUCHER 6+", type: .bulk(quantity: 6, price: 4.0));
        
        // Then: add 4 VOUCHER
        cart.addProduct(VOUCHER, quantity: 4);
        
        // Expect: 4x5.0 = 20.0
        XCTAssertEqual(4, cart.itemCount, "cart should have 4 items");
        XCTAssertEqual(0, cart.discount, "discount should be 0.00");
        XCTAssertEqual(20.0, cart.total, "total should be 20.0");
        
        // Then: add 2 VOUCHER
        cart.addProduct(VOUCHER, quantity: 2);
        
        // Expect: 6x4.0 = 24.0
        XCTAssertEqual(6, cart.itemCount, "cart should have 6 items");
        XCTAssertEqual(6.0, cart.discount, "discount should be 6.00");
        XCTAssertEqual(24.0, cart.total, "total should be 24.00");
        
        // Then: add 6 VOUCHER
        cart.addProduct(VOUCHER, quantity: 6);
        
        // Expect: 12x4.0 = 48.0
        XCTAssertEqual(12, cart.itemCount, "cart should have 12 items");
        XCTAssertEqual(12.0, cart.discount, "discount should be 12.00");
        XCTAssertEqual(48.0, cart.total, "total should be 48.00");
        
    }
    
    func testMixedPromotions1() {
        
        // When: cart is empty
        // Promotion #1: 2x1 VOUCHER
        cart.addPromotion(code: "VOUCHER", name: "2x1 VOUCHER", type: .combo(quantity: 2, free: 1));
        // Promotion #2: Bulk TSHIRT
        cart.addPromotion(code: "TSHIRT", name: "TSHIRT 3+", type: .bulk(quantity: 3, price: 19.0));
        
        
        // Then: Add Items: VOUCHER, TSHIRT, MUG
        cart.addProduct(VOUCHER);
        cart.addProduct(TSHIRT);
        cart.addProduct(MUG);
        
        // Expect: (1x5.0) + (1x20.0) + (1x7.5) = 32.50
        XCTAssertEqual(3, cart.itemCount, "cart should have 3 items");
        XCTAssertEqual(0, cart.discount, "discount should be 0.00");
        XCTAssertEqual(32.5, cart.total, "total should be 32.50");
        
    }
    
    func testMixedPromotions2() {
        
        // When: cart is empty
        // Promotion #1: 2x1 VOUCHER
        cart.addPromotion(code: "VOUCHER", name: "2x1 VOUCHER", type: .combo(quantity: 2, free: 1));
        // Promotion #2: Bulk TSHIRT
        cart.addPromotion(code: "TSHIRT", name: "TSHIRT 3+", type: .bulk(quantity: 3, price: 19.0));
        
        
        // Then: Add Items: VOUCHER, TSHIRT, VOUCHER
        cart.addProduct(VOUCHER);
        cart.addProduct(TSHIRT);
        cart.addProduct(VOUCHER);
        
        // Expect: [2x1](1x5.0) + (2x20.0) = 25.00
        XCTAssertEqual(3, cart.itemCount, "cart should have 3 items");
        XCTAssertEqual(5.0, cart.discount, "discount should be 0.00");
        XCTAssertEqual(25.00, cart.total, "total should be 25.00");
    }
    
    func testMixedPromotions3() {
        
        // When: cart is empty
        // Promotion #1: 2x1 VOUCHER
        cart.addPromotion(code: "VOUCHER", name: "2x1 VOUCHER", type: .combo(quantity: 2, free: 1));
        // Promotion #2: Bulk TSHIRT
        cart.addPromotion(code: "TSHIRT", name: "TSHIRT 3+", type: .bulk(quantity: 3, price: 19.0));
        
        
        // Then: Add Items: TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT
        cart.addProduct(TSHIRT);
        cart.addProduct(TSHIRT);
        cart.addProduct(TSHIRT);
        cart.addProduct(VOUCHER);
        cart.addProduct(TSHIRT);
        
        // Expect: (1x5.0) + (4x19.0) = 81.00
        XCTAssertEqual(5, cart.itemCount, "cart should have 5 items");
        XCTAssertEqual(4.0, cart.discount, "discount should be 4.00");
        XCTAssertEqual(81.00, cart.total, "total should be 81.00");
    }
    
    func testIncreaseProducts() {
        
        // When: cart has items
        cart.addProduct(TSHIRT);
        cart.addProduct(VOUCHER);
        cart.addProduct(TSHIRT);
        
        var tshirts = cart.cartItems.first(where: { return $0.code == TSHIRT.code })
        var vouchers = cart.cartItems.first(where: { return $0.code == VOUCHER.code });
        XCTAssertEqual(2, tshirts?.quantity, "cart should contain 2 TSHIRT");
        XCTAssertEqual(1, vouchers?.quantity, "cart should contain 1 VOUCHER");
        
        // Then: increase TSHIRT
        cart.increaseProduct(TSHIRT);
        
        // Expect: TSHIRT count should be 3
        tshirts = cart.cartItems.first(where: { return $0.code == TSHIRT.code });
        vouchers = cart.cartItems.first(where: { return $0.code == VOUCHER.code });
        XCTAssertEqual(3, tshirts?.quantity, "cart should contain 3 TSHIRT");
        XCTAssertEqual(1, vouchers?.quantity, "cart should contain 1 VOUCHER");
        
        // Then: increase VOUCHER
        cart.increaseProduct(VOUCHER);
        
        // Expect: VOUCHER count should be 2
        tshirts = cart.cartItems.first(where: { return $0.code == TSHIRT.code });
        vouchers = cart.cartItems.first(where: { return $0.code == VOUCHER.code });
        XCTAssertEqual(3, tshirts?.quantity, "cart should contain 3 TSHIRT");
        XCTAssertEqual(2, vouchers?.quantity, "cart should contain 2 VOUCHER");
        
    }
    
    func testDecreaseProducts() {
        
        // When: cart has items
        cart.addProduct(TSHIRT, quantity: 3);
        cart.addProduct(VOUCHER);
        
        var tshirts = cart.cartItems.first(where: { return $0.code == TSHIRT.code })
        var vouchers = cart.cartItems.first(where: { return $0.code == VOUCHER.code });
        XCTAssertEqual(3, tshirts?.quantity, "cart should contain 3 TSHIRT");
        XCTAssertEqual(1, vouchers?.quantity, "cart should contain 1 VOUCHER");
        
        // Then: decrease TSHIRT
        cart.decreaseProduct(TSHIRT);
        
        // Expect: TSHIRT count should be 2
        tshirts = cart.cartItems.first(where: { return $0.code == TSHIRT.code });
        vouchers = cart.cartItems.first(where: { return $0.code == VOUCHER.code });
        XCTAssertEqual(2, tshirts?.quantity, "cart should contain 2 TSHIRT");
        XCTAssertEqual(1, vouchers?.quantity, "cart should contain 1 VOUCHER");
        
        // Then: decrease TSHIRT
        cart.decreaseProduct(TSHIRT);
        
        // Expect: TSHIRT count should be 1
        tshirts = cart.cartItems.first(where: { return $0.code == TSHIRT.code });
        vouchers = cart.cartItems.first(where: { return $0.code == VOUCHER.code });
        XCTAssertEqual(1, tshirts?.quantity, "cart should contain 1 TSHIRT");
        XCTAssertEqual(1, vouchers?.quantity, "cart should contain 1 VOUCHER");
        
    }
    
    func testDecreaseShouldntFallBelow0() {
        
        // When: cart has items
        cart.addProduct(TSHIRT, quantity: 3);
        cart.addProduct(VOUCHER);
        
        var tshirts = cart.cartItems.first(where: { return $0.code == TSHIRT.code })
        var vouchers = cart.cartItems.first(where: { return $0.code == VOUCHER.code });
        XCTAssertEqual(3, tshirts?.quantity, "cart should contain 3 TSHIRT");
        XCTAssertEqual(1, vouchers?.quantity, "cart should contain 1 VOUCHER");
        
        // Then: decrease VOUCHER and TSHIRT
        cart.decreaseProduct(VOUCHER);
        cart.decreaseProduct(TSHIRT);
        cart.decreaseProduct(TSHIRT);
        cart.decreaseProduct(TSHIRT);
        
        // Expect: cart shouldn't change
        tshirts = cart.cartItems.first(where: { return $0.code == TSHIRT.code });
        vouchers = cart.cartItems.first(where: { return $0.code == VOUCHER.code });
        XCTAssertEqual(1, tshirts?.quantity, "cart should contain 1 TSHIRT");
        XCTAssertEqual(1, vouchers?.quantity, "cart should contain 1 VOUCHER");
        
        
    }
    
    func testRemoveItems() {
        
        // When: cart has items
        cart.addProduct(TSHIRT);
        cart.addProduct(TSHIRT);
        cart.addProduct(TSHIRT);
        cart.addProduct(VOUCHER);
        cart.addProduct(TSHIRT);
        
        // Then: Remove TSHIRT
        cart.removeProduct(TSHIRT);
        
        // Expect: cart should contain a single VOUCHER
        XCTAssertEqual(1, cart.itemCount, "cart should have 1 item");
        XCTAssertEqual(VOUCHER.code, cart.cartItems.first!.code, "cart should have 1 VOUCHER");
        
        // Then: Remove VOUCHER
        cart.removeProduct(VOUCHER);
        
        // Expect: cart should be empty
        XCTAssertTrue(cart.isEmpty, "cart should be empty");
        XCTAssertEqual(0, cart.itemCount, "cart should have 0 items");
        XCTAssertEqual(0, cart.total, "cart should have 0 items");
        XCTAssertEqual(0, cart.discount, "cart should have 0 items");
        
    }
    
}
