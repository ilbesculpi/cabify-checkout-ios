//
//  CartPresenter.swift
//  Cabify Checkout
//
//  Handles the behavior of the Cart Screen.
//

import UIKit

class CartPresenter: BasePresenter, CartPresenterContract {

    
    // MARK: - Properties
    weak var view: CartViewContract!
    var cart: ProductCart
    
    
    // MARK: - Initialization
    
    init(view: CartViewContract, cart: ProductCart) {
        self.view = view;
        self.cart = cart;
    }
    
    
    // MARK: - CartPresenter
    
    func onViewCreated() {
        print("[DEBUG] CartPresenter::onViewCreated()");
        view.displayProducts(cart.cartItems);
    }
    
    
}
