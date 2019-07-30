//
//  ProductCartItem.swift
//  Cabify Checkout
//
//  Represents a Product Item added to the Cart.
//

import UIKit

class ProductCartItem : Equatable {
    
    
    // MARK: - Properties
    var product: Product;
    var quantity: Int = 0;
    
    var code: String {
        return product.code;
    }
    
    var name: String {
        return product.name;
    }
    
    var price: Float {
        return product.price;
    }
    
    var totalPrice: Float {
        return Float(quantity) * price;
    }
    
    
    // MARK: - Initialization
    
    init(product: Product, quantity: Int) {
        self.product = product;
        self.quantity = quantity;
    }
    
    static func == (lhs: ProductCartItem, rhs: ProductCartItem) -> Bool {
        return lhs.code == rhs.code;
    }
    
}
