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
    
    func loadPromotions() -> Promise<[ProductCart.Discount]>
    
}
