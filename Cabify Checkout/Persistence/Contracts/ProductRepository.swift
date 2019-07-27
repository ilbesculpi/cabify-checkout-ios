//
//  ProductRepository.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
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
