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
    }
    
    
}
