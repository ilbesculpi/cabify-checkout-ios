//
//  ProductListFixture.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import Foundation
@testable import Cabify_Checkout

class ProductListFixture {
    
    var productList: [Product] = {
        let products = [
            Product(code: "VOUCHER", name: "Cabify Voucher", price: 5.0),
            Product(code: "TSHIRT", name: "Cabify T-Shirt", price: 20.0),
            Product(code: "MUG", name: "Cabify Coffee Mug", price: 7.5),
        ];
        return products;
    }();
    
}
