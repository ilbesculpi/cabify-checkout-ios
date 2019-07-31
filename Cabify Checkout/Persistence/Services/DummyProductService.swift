//
//  DummyProductService.swift
//  Cabify Checkout
//
//  Provides services for storing/retrieving the dummy Products.
//  Useful for UI tests
//

import Foundation
import Promises

class DummyProductService: ProductRepository {
    
    func fetchProducts() -> Promise<[Product]> {
        let promise = Promise<[Product]> { (resolve, reject) in
            let products = [
                Product(code: "VOUCHER", name: "Cabify Voucher", price: 5.0),
                Product(code: "TSHIRT", name: "Cabify T-Shirt", price: 20.0),
                Product(code: "MUG", name: "Cabify Coffee Mug", price: 7.5),
                Product(code: "KEYCHAINTAG", name: "Cabify KeyChain TAG", price: 10.0),
            ];
            resolve(products);
        }
        return promise;
    }

}
