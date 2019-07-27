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
    private var discounts: [Discount] = [];
    private var _discount: Float = 0;
    private var _total: Float = 0;
    
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
        return _discount;
    }
    
    var total: Float {
        return _total;
    }
    
    func addProduct(_ product: Product, quantity: Int = 1) {
        if let current = items.first(where: { return $0.code == product.code }) {
            current.quantity += quantity;
        }
        else {
            let newItem = ProductItem(code: product.code, price: product.price, quantity: quantity);
            items.append(newItem);
        }
        calculate();
    }
    
    func addDiscount(code: String, name: String, type: DiscountType) {
        let discount = Discount(name: name, code: code, type: type);
        discounts.append(discount);
    }
    
    
    // MARK: - Totals
    
    func calculate() {
        
        var sum: Float = 0;
        
        _discount = 0;
        
        for item in items {
            
            // Check if there are discounts for the current product
            let itemDiscounts = discounts.filter({ return $0.code == item.code })
            
            if itemDiscounts.isEmpty {
                // Return default calculation: total = price x quantity
                sum += ( item.price * Float(item.quantity) );
            }
            else {
                
                // Apply discounts
                for discount in itemDiscounts {
                    sum += applyDiscount(to: item, discount: discount);
                }
            }
        }
        
        _total = sum;
    }
    
    /**
     Evaluate the discount.
     - TODO: don't update discount as part of the state. It's better to return a tuple
     */
    private func applyDiscount(to item: ProductItem, discount: Discount) -> Float {
        
        let noDiscountPrice: Float = ( item.price * Float(item.quantity) );
        
        switch( discount.type ) {
            
            case .combo(let quantity, let freeItems):
                if item.quantity >= quantity {
                    // Apply combo by reducing free items from the quantity
                    let totalFreeItems = (item.quantity / quantity) * freeItems
                    let price = ( item.price * Float(item.quantity - totalFreeItems) );
                    // Update discount
                    _discount += (noDiscountPrice - price);
                    return price;
                }
            
            case .bulk(let quantity, let discountPrice):
                if item.quantity >= quantity {
                    // If item quantity is over discount rule quantity, use the discount price
                    let price = ( Float(item.quantity) * discountPrice);
                    // Update discount
                    _discount += (noDiscountPrice - price);
                    return price;
                }
        
        }
        
        // Don't apply discount
        return noDiscountPrice;
        
    }
    
    
    // MARK: - Definitions
    
    class ProductItem : Equatable {
        
        var quantity: Int = 0;
        var price: Float = 0;
        var code: String;
        
        init(code: String, price: Float, quantity: Int) {
            self.code = code;
            self.price = price;
            self.quantity = quantity;
        }
        
        static func == (lhs: ProductItem, rhs: ProductItem) -> Bool {
            return lhs.code == rhs.code;
        }
        
    }
    
    enum DiscountType {
        
        case combo(quantity: Int, free: Int)
        case bulk(quantity: Int, price: Float)
        
    }
    
    class Discount {
    
        var name: String
        var code: String
        var type: DiscountType
        
        init(name: String, code: String, type: DiscountType) {
            self.name = name;
            self.code = code;
            self.type = type;
        }
        
    }
    
}
