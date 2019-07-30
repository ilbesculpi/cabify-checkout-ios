//
//  ProductCart.swift
//  Cabify Checkout
//
//  Product Cart Model.
//  Handles the logic of adding/removing products to the shopping cart.
//

import Foundation
import RxSwift

class ProductCart: NSObject {

    
    // MARK: - Properties
    private var items: [ProductCartItem] = [];
    private var promotions: [Promotion] = [];
    private var _discount: Float = 0;
    private var _total: Float = 0;
    private var observableChanges: Observable<Void>
    
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
    
    var cartItems: [ProductCartItem] {
        return items;
    }
    
    
    // MARK: - Initialization
    
    override init() {
        observableChanges = Observable.create { (observer) in
            return Disposables.create();
        }
    }
    
    
    // MARK: - Subscribe
    
    
    
    // MARK: - Products
    
    func addProduct(_ product: Product, quantity: Int = 1) {
        if let current = items.first(where: { return $0.code == product.code }) {
            current.quantity += quantity;
        }
        else {
            let newItem = ProductCartItem(product: product, quantity: quantity);
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
        
        // notify observers
        
    }
    
    /**
     Evaluate the promotion.
     - Return: tuple with price to be applied and the discount obtained.
     */
    private func applyPromotion(to item: ProductCartItem, promotion: Promotion) -> (price: Float, discount: Float) {
        
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
    
    
}
