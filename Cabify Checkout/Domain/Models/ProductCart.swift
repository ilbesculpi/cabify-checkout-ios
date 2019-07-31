//
//  ProductCart.swift
//  Cabify Checkout
//
//  Product Cart Model.
//  Handles the logic of adding/removing products to the shopping cart.
//

import Foundation

class ProductCart: NSObject {

    
    // MARK: - Properties
    private var items: [ProductCartItem] = [];
    private var promotions: [Promotion] = [];
    
    @objc dynamic var updatedAt = Date();
    
    var isEmpty: Bool {
        get {
            return items.isEmpty;
        }
    }
    
    var itemCount: Int {
        return items.reduce(0, { (result, item) -> Int in
            return result + item.quantity;
        })
    }
    
    var discount: Float {
        return items.reduce(0, { (result, item) -> Float in
            return result + item.savings;
        })
    }
    
    var total: Float {
        return items.reduce(0, { (result, item) -> Float in
            return result + item.totalPrice;
        })
    }
    
    var cartItems: [ProductCartItem] {
        return items;
    }
    
    
    // MARK: - Products
    
    func empty() {
        items = [];
        updatedAt = Date();
    }
    
    func addProduct(_ product: Product, quantity: Int = 1) {
        if let current = items.first(where: { return $0.code == product.code }) {
            current.quantity += quantity;
        }
        else {
            let newItem = ProductCartItem(product: product, quantity: quantity);
            items.append(newItem);
        }
        update();
    }
    
    func update() {
        calculate();
        updatedAt = Date();
    }
    
    func increaseProduct(_ product: Product) {
        increaseProduct(code: product.code);
    }
    
    func increaseProduct(code: String) {
        if let current = items.first(where: { return $0.code == code }) {
            current.quantity += 1;
            update();
        }
    }
    
    func decreaseProduct(_ product: Product) {
        decreaseProduct(code: product.code);
    }
    
    func decreaseProduct(code: String) {
        if let current = items.first(where: { return $0.code == code }) {
            if current.quantity > 1 {
                current.quantity -= 1;
                update();
            }
        }
    }
    
    func removeProduct(_ product: Product) {
        removeProduct(code: product.code);
    }
    
    func removeProduct(code: String) {
        items.removeAll(where: { return $0.code == code });
        update();
    }
    
    
    // MARK: - Promotions
    
    func addPromotion(code: String, name: String, type: PromotionType) {
        let promotion = Promotion(name: name, code: code, type: type);
        addPromotion(promotion);
    }
    
    func addPromotion(_ promotion: Promotion) {
        promotions.append(promotion);
    }
    
    func addPromotions(_ promotions: [Promotion]) {
        for promotion in promotions {
            addPromotion(promotion);
        }
    }
    
    
    // MARK: - Totals
    
    func calculate() {
        
        for item in items {
            
            // Check if there are promotions for the current product
            let itemPromotions = promotions.filter({ return $0.code == item.code })
            
            if itemPromotions.isEmpty {
                // Apply default price: unitPrice x quantity
                item.totalPrice = ( item.unitPrice * Float(item.quantity) );
            }
            else {
                
                // Apply promotions
                for promotion in itemPromotions {
                    applyPromotion(to: item, promotion: promotion);
                }
            }
        }
        
    }
    
    /**
     Evaluate the promotion and update the item with the total/savings applied.
     */
    private func applyPromotion(to item: ProductCartItem, promotion: Promotion) {
        
        let noDiscountPrice: Float = ( item.unitPrice * Float(item.quantity) );
        item.totalPrice = noDiscountPrice;
        item.savings = 0;
        
        if( !promotion.isActive ) {
            // Don't apply discount
            return
        }
        
        switch( promotion.type ) {
            
            case .combo(let quantity, let freeItems):
                if item.quantity >= quantity {
                    // Apply combo by reducing free items from the quantity
                    let totalFreeItems = (item.quantity / quantity) * freeItems
                    let price = ( item.unitPrice * Float(item.quantity - totalFreeItems) );
                    let discount = (noDiscountPrice - price);
                    item.discountPrice = item.unitPrice;
                    item.totalPrice = price;
                    item.addPromotion(promotion.name, savings: discount);
                }
            
            case .bulk(let quantity, let discountPrice):
                if item.quantity >= quantity {
                    // If item quantity is over discount rule quantity, use the discount price
                    let price = ( Float(item.quantity) * discountPrice);
                    let discount = (noDiscountPrice - price);
                    item.discountPrice = discountPrice;
                    item.totalPrice = price;
                    item.addPromotion(promotion.name, savings: discount);
                }
        
        }
        
        // Don't apply discount
        
    }
    
    
}
