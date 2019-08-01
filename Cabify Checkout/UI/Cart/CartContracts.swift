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
    
    func displayCart();
    func displayEmptyCart();
    func displayItemCount(_ count: Int);
    func displayTotal(price: Float);
    func displayCartItems(_ items: [ProductCartItem]);
    func displayCheckoutScreen();
    func setCheckoutState(enabled: Bool);
    
}

protocol CartPresenterContract : BasePresenterContract, CartListItemDelegate {
    
    var view: CartViewContract! { get set }
    var cart: ProductCart { get set }
    var cartService: CartRepository! { get set }
    
    func onViewCreated();
    func performCheckout();
    
}

protocol CartRouterContract : BaseRouterContract {
    
    var view: CartViewContract! { get set }
    
    func displayCheckoutScreen();
    
}
