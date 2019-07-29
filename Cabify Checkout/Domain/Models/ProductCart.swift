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
    private var promotions: [Promotion] = [];
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
    
    
    // MARK: - Products
    
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
    
    func empty() {
        items = [];
        _total = 0;
        _discount = 0;
    }
    
    
    // MARK: - Promotions
    
    func addDiscount(code: String, name: String, type: PromotionType) {
        let discount = Promotion(name: name, code: code, type: type);
        promotions.append(discount);
    }
    
    
    // MARK: - Totals
    
    func calculate() {
        
        var totalPrice: Float = 0;
        var cartDiscount: Float = 0;
        
        for item in items {
            
            // Check if there are promotions for the current product
            let itemPromotions = promotions.filter({ return $0.code == item.code })
            
            if itemPromotions.isEmpty {
                // Return default calculation: total = price x quantity
                totalPrice += ( item.price * Float(item.quantity) );
            }
            else {
                
                // Apply promotions
                for promotion in itemPromotions {
                    let promo = applyPromotion(to: item, promotion: promotion);
                    totalPrice += promo.price;
                    cartDiscount += promo.discount;
                }
            }
        }
        
        _total = totalPrice;
        _discount = cartDiscount;
    }
    
    /**
     Evaluate the promotion.
     - Return: tuple with price to be applied and the discount obtained.
     */
    private func applyPromotion(to item: ProductItem, promotion: Promotion) -> (price: Float, discount: Float) {
        
        let noDiscountPrice: Float = ( item.price * Float(item.quantity) );
        
        if( !promotion.isActive ) {
            // Don't apply discount
            return (price: noDiscountPrice, discount: 0);
        }
        
        switch( promotion.type ) {
            
            case .combo(let quantity, let freeItems):
                if item.quantity >= quantity {
                    // Apply combo by reducing free items from the quantity
                    let totalFreeItems = (item.quantity / quantity) * freeItems
                    let price = ( item.price * Float(item.quantity - totalFreeItems) );
                    let discount = (noDiscountPrice - price);
                    return (price: price, discount: discount);
                }
            
            case .bulk(let quantity, let discountPrice):
                if item.quantity >= quantity {
                    // If item quantity is over discount rule quantity, use the discount price
                    let price = ( Float(item.quantity) * discountPrice);
                    let discount = (noDiscountPrice - price);
                    return (price: price, discount: discount);
                }
        
        }
        
        // Don't apply discount
        return (price: noDiscountPrice, discount: 0);
        
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
    
    
}
