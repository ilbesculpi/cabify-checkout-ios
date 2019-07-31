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

extension Product {
    
    class func list(json: [[String: Any]]) throws -> [Product] {
        return try json.map({ (item) -> Product in
            return try Product.from(json: item);
        });
    }
    
    class func from(json: [String : Any]) throws -> Product {
        let product = Product(
            code: json["code"] as! String,
            name: json["name"] as! String,
            price: json["price"] as! Float
        );
        return product;
    }
    
}

// MARK: - Equatable
extension Product: Equatable {
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.code == rhs.code;
    }
    
}
