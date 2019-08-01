//
//  CheckoutFixture.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 8/1/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import Foundation
@testable import Cabify_Checkout

class CheckoutFixture {
    
    var cartItems: [ProductCartItem] = {
        let items = [
            ProductCartItem(code: "TSHIRT", name: "Cabify T-Shirt", unitPrice: 20.0, quantity: 5),
            ProductCartItem(code: "MUG", name: "Cabify Coffee Mug", unitPrice: 7.5, quantity: 2),
        ];
        return items;
    }();
    
}
