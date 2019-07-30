//
//  ProductListContracts.swift
//  Cabify Checkout
//
//  Define the UI contracts for the Product List Screen.
//

import Foundation

protocol ProductListViewContract : BaseViewContract {
    
    var presenter: ProductListPresenterContract! { get set }
    var router: ProductListRouterContract! { get set }
    
    func displayProducts(_ products: [Product]);
    
}

protocol ProductListPresenterContract : BasePresenterContract {
    
    var view: ProductListViewContract! { get set }
    var productRepository: ProductRepository! { get set }
    var cart: ProductCart { get set }
    
    func onViewCreated()
    func fetchProducts()
    func addProduct(product: Product)
    
}

protocol ProductListRouterContract : BaseRouterContract {
    
    var view: ProductListViewContract! { get set }
    
}
