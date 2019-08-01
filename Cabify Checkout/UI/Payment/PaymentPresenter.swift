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
    var paymentService: PaymentRepository!
    
    
    // MARK: - Initialization
    
    init(view: PaymentViewContract, amount: Float) {
        self.view = view;
        self.amount = amount;
    }
    
    
    // MARK: - PaymentPresenterContract
    
    func onViewCreated() {
        
        print("[DEBUG] PaymentPresenter::onViewCreated()");
        view.displayProcessingPaymentView();
        
        paymentService.processPayment(amount: amount) { [weak self] (result) in
            
            if case .success(_) = result {
                self?.view.hideProcessingPaymentView();
                self?.view.displayPaymentSuccessView();
            }
        
            if case .failure(_) = result {
                self?.view.hideProcessingPaymentView();
                self?.view.displayPaymentErrorView(message: "Operation failed.");
            }
            
        }
        
    }
    
    
}
