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
    
    static var defaultCart: ProductCart { get set }
    
    func loadPromotions() -> Promise<[Promotion]>
    
}
