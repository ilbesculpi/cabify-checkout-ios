//
//  ProductRepository.swift
//  Cabify Checkout
//
//  Define ProductRepository public interface
//

import Foundation
import Promises

enum ServiceError : Error {
    
    case badRequest
    case invalidResponse
    case unkownError
    
}

protocol ProductRepository {
    
    func fetchProducts() -> Promise<[Product]>
    
}
