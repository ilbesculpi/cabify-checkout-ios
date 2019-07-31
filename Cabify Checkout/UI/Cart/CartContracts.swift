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
    
    func displayItemCount(_ count: Int);
    func displayTotal(price: Float);
    func displayProducts(_ products: [ProductCartItem]);
    
}

protocol CartPresenterContract : BasePresenterContract, CartListItemDelegate {
    
    var view: CartViewContract! { get set }
    var cart: ProductCart { get set }
    var cartService: CartRepository! { get set }
    
    func onViewCreated();
    func onProceedToCheckout();
    
}

protocol CartRouterContract : BaseRouterContract {
    
    var view: CartViewContract! { get set }
    
    func displayCheckoutScreen();
    
}
