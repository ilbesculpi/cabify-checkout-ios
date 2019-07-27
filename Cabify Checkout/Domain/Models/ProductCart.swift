//
//  ProductCart.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/27/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class ProductCart: NSObject {

    private var items: [ProductItem] = [];
    
    var isEmpty: Bool {
        get {
            return items.isEmpty;
        }
    }
    
    var itemCount: Int {
        get {
            return items.reduce(0, { (result, item) -> Int in
                return result + item.quantity;
            })
        }
    }
    
    var discount: Float {
        get {
            return 0;
        }
    }
    
    var total: Float {
        get {
            var sum: Float = 0;
            for item in items {
                sum += ( item.price * Float(item.quantity) );
            }
            return sum;
        }
    }
    
    func addProduct(_ product: Product) {
        if let current = items.first(where: { return $0.code == product.code }) {
            current.quantity += 1;
        }
        else {
            let newItem = ProductItem(code: product.code, price: product.price);
            items.append(newItem);
        }
    }
    
    
    
    // MARK: - Definitions
    
    class ProductItem : Equatable {
        
        var quantity: Int = 0;
        var price: Float = 0;
        var code: String;
        
        init(code: String, price: Float) {
            self.code = code;
            self.price = price;
            self.quantity = 1;
        }
        
        static func == (lhs: ProductItem, rhs: ProductItem) -> Bool {
            return lhs.code == rhs.code;
        }
        
    }
    
}
