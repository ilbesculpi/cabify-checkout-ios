//
//  ProductListContracts.swift
//  Cabify Checkout
//
//  Define the UI contracts for the Product List Screen.
//

import Foundation

protocol ProductListViewContract : class {
    
    var presenter: ProductListPresenterContract! { get set }
    var router: ProductListRouterContract! { get set }
    
    func showLoadingView();
    func hideLoadingView();
    func displayError(message: String);
    func displayProducts(_ products: [Product]);
    
}

protocol ProductListPresenterContract : class {
    
    var view: ProductListViewContract! { get set }
    var productRepository: ProductRepository! { get set }
    
    func onViewCreated()
    func fetchProducts()
    
}

protocol ProductListRouterContract : class {
    
    var view: ProductListViewContract! { get set }
    
}
