//
//  Product.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import Foundation

class Product {
    
    var code: String;
    var name: String;
    var price: Float;
    
    init(code: String, name: String, price: Float) {
        self.code = code;
        self.name = name;
        self.price = price;
    }
    
}
