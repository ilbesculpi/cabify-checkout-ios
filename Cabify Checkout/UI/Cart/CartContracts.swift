//
//  CartContracts.swift
//  Cabify Checkout
//
//  Define the UI contracts for the Cart Screen.
//

import Foundation


protocol CartViewContract : BaseViewContract {
    
    var presenter: CartPresenterContract! { get set }
    var router: CartRouterContract! { get set }
    
}

protocol CartPresenterContract : BasePresenterContract {
    
    var view: CartViewContract! { get set }
    var cart: ProductCart { get set }
    
    func onViewCreated();
    
}

protocol CartRouterContract : BaseRouterContract {
    
    var view: CartViewContract! { get set }
    
    func displayCheckoutScreen();
    
}
