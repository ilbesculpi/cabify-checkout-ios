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
        // Observe cart updates using KVO
        addObserver(self, forKeyPath: #keyPath(cart.updatedAt), options: [.old, .new], context: nil);
        updateView();
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        updateView();
    }
    
    func updateView() {
        view.displayItemCount(cart.itemCount);
        view.displayTotal(price: cart.total);
        view.displayCartItems(cart.cartItems);
        view.setCheckoutState(enabled: !cart.isEmpty);
    }
    
    func performCheckout() {
        cartService.saveCart(cart).always { [weak self] in
            guard let ref = self else {
                return;
            }
            if ref.cart.isEmpty {
                self?.view.displayError(message: "Cart is empty");
            }
            else {
                self?.view.displayCheckoutScreen();
            }
        }
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
