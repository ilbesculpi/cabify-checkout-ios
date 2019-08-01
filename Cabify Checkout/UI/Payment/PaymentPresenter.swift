//
//  PaymentPresenter.swift
//  Cabify Checkout
//
//  Handles the behavior of the Checkout Screen.
//

import UIKit

class PaymentPresenter: BasePresenter, PaymentPresenterContract {

    // MARK: - Properties
    weak var view: PaymentViewContract!
    var amount: Float
    var cart: ProductCart
    var paymentService: PaymentRepository!
    var cartService: CartRepository!
    
    
    // MARK: - Initialization
    
    init(view: PaymentViewContract, cart: ProductCart, amount: Float) {
        self.view = view;
        self.amount = amount;
        self.cart = cart;
    }
    
    
    // MARK: - PaymentPresenterContract
    
    func onViewCreated() {
        
        print("[DEBUG] PaymentPresenter::onViewCreated()");
        view.displayProcessingPaymentView();
        
        paymentService.processPayment(amount: amount) { [weak self] (result) in
            
            if case .success(_) = result {
                // empty cart
                guard let ref = self else {
                    return;
                }
                self?.cartService.emptyCart(ref.cart)
                    .always {
                        self?.view.hideProcessingPaymentView();
                        self?.view.displayPaymentSuccessView();
                    }
            }
        
            if case .failure(_) = result {
                self?.view.hideProcessingPaymentView();
                self?.view.displayPaymentErrorView(message: "Operation failed.");
            }
            
        }
        
    }
    
    
}
