//
//  CartRepository.swift
//  Cabify Checkout
//
//  Define Product Cart Repository public interface
//

import Foundation
import Promises

enum CartError : Error {
    
    case loadPromotionsError
    
}

protocol CartRepository {
    
    var defaultCart: ProductCart { get set }
    
    func loadPromotions() -> Promise<[Promotion]>
    
    func loadCart(into cart: ProductCart) -> Promise<ProductCart>
    
    func saveCart(_ cart: ProductCart) -> Promise<Void>
    
    func emptyCart(_ cart: ProductCart) -> Promise<Void>
    
}
