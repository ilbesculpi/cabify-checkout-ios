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
    @objc var cart: ProductCart
    
    
    // MARK: - Initialization
    
    init(view: CartViewContract, cart: ProductCart) {
        self.view = view;
        self.cart = cart;
    }
    
    
    // MARK: - CartPresenter
    
    func onViewCreated() {
        print("[DEBUG] CartPresenter::onViewCreated()");
        view.displayProducts(cart.cartItems);
        // Add Observers to the Cart properties using KVO
        addObserver(self, forKeyPath: #keyPath(cart.updatedAt), options: [.old, .new], context: nil);
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        view.displayItemCount(cart.itemCount);
        view.displayTotal(price: cart.total);
        view.displayProducts(cart.cartItems);
    }
    
    func increaseProduct(_ product: ProductCartItem) {
        cart.increaseProduct(product.product);
    }
    
    func decreaseProduct(_ product: ProductCartItem) {
        cart.decreaseProduct(product.product);
    }
    
    func removeProduct(_ product: ProductCartItem) {
        cart.removeProduct(product.product);
    }
    
}
