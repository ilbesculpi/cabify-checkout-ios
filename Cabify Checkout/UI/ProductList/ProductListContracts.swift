//
//  ProductListContracts.swift
//  Cabify Checkout
//
//  Define the UI contracts for the Product List Screen.
//

import Foundation

protocol ProductListViewContract {
    
    func displayProducts(_ products: [Product])
    
}

protocol ProductListPresenterContract {
    
    func onViewCreated()
    func fetchProducts()
    
}

protocol ProductListRouterContract {
    
}
