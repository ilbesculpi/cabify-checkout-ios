//
//  CheckoutContracts.swift
//  Cabify Checkout
//
//  Define the UI contracts for the Checkout Screen.
//

import Foundation

protocol CheckoutViewContract : BaseViewContract {
    
    var presenter: CheckoutPresenterContract! { get set }
    var router: CheckoutRouterContract! { get set }
    
    func displayTotal(price: Float);
    func displaySubtotal(price: Float);
    func displayDiscounts(price: Float);
    func displayCartItems(_ items: [ProductCartItem]);
    
    func displayPaymentScreen();
    
}

protocol CheckoutPresenterContract : BasePresenterContract {
    
    var view: CheckoutViewContract! { get set }
    var cart: ProductCart { get set }
    
    func onViewCreated();
    func paymentAction();
    
}

protocol CheckoutRouterContract : BaseRouterContract {
    
    var view: CheckoutViewContract! { get set }
    
    func displayPaymentScreen();
    
}
