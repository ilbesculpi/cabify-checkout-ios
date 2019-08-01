//
//  CheckoutPresenter.swift
//  Cabify Checkout
//
//  Handles the behavior of the Checkout Screen.
//

import UIKit

class CheckoutPresenter: BasePresenter, CheckoutPresenterContract {
    
    // MARK: - Properties
    weak var view: CheckoutViewContract!
    var cart: ProductCart
    
    
    // MARK: - Initialization
    
    init(view: CheckoutViewContract, cart: ProductCart) {
        self.view = view;
        self.cart = cart;
    }
    
    
    // MARK: - CheckoutPresenter
    
    func onViewCreated() {
        print("[DEBUG] CheckoutPresenter::onViewCreated()");
        view.displayTotal(price: cart.total);
        view.displaySubtotal(price: cart.subtotal);
        view.displayDiscounts(price: cart.discount);
        view.displayCartItems(cart.cartItems);
    }
    
    func paymentAction() {
        view.displayPaymentScreen();
    }
    
    
}
