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
    var cartService: CartRepository!
    
    
    // MARK: - Initialization
    
    init(view: CartViewContract, cart: ProductCart) {
        self.view = view;
        self.cart = cart;
    }
    
    
    // MARK: - CartPresenter
    
    func onViewCreated() {
        print("[DEBUG] CartPresenter::onViewCreated()");
        // Add Observers to the Cart properties using KVO
        addObserver(self, forKeyPath: #keyPath(cart.updatedAt), options: [.old, .new], context: nil);
        updateView();
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        updateView();
    }
    
    func updateView() {
        view.displayItemCount(cart.itemCount);
        view.displayTotal(price: cart.total);
        view.displayProducts(cart.cartItems);
    }
    
    func onProceedToCheckout() {
        cartService.saveCart(cart).always {}
    }
    
    
    // MARK: - CartListItemDelegate
    
    func increaseProduct(_ product: ProductCartItem) {
        cart.increaseProduct(code: product.code);
    }
    
    func decreaseProduct(_ product: ProductCartItem) {
        cart.decreaseProduct(code: product.code);
    }
    
    func removeProduct(_ product: ProductCartItem) {
        cart.removeProduct(code: product.code);
    }
    
}
