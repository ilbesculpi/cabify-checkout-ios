//
//  ProductCartItem.swift
//  Cabify Checkout
//
//  Represents a Product Item added to the Cart.
//

import Foundation

class ProductCartItem {
    
    
    // MARK: - Properties
    //var product: Product;
    var quantity: Int = 0;
    var code: String;
    var name: String;
    var unitPrice: Float;
    var discountPrice: Float = 0;
    var totalPrice: Float = 0;
    var savings: Float = 0;
    
    var promotion: String?
    
    var hasPromotion: Bool {
        return promotion != nil;
    }
    
    
    // MARK: - Initialization
    
    init(product: Product, quantity: Int) {
        //self.product = product;
        self.code = product.code;
        self.name = product.name;
        self.unitPrice = product.price;
        self.quantity = quantity;
        self.totalPrice = Float(quantity) * unitPrice;
        self.savings = 0;
    }
    
    
    func addPromotion(_ promotion: String, savings: Float) {
        self.promotion = promotion;
        self.savings = savings;
    }
    
}

// MARK: - Equatable
extension ProductCartItem: Equatable {
    
    static func == (lhs: ProductCartItem, rhs: ProductCartItem) -> Bool {
        return lhs.code == rhs.code;
    }
    
}
