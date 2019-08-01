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
    
    
    // MARK: - Initialization
    
    init(view: PaymentViewContract, amount: Float) {
        self.view = view;
        self.amount = amount;
    }
    
    
    // MARK: - PaymentPresenterContract
    
    func onViewCreated() {
        
        print("[DEBUG] PaymentPresenter::onViewCreated()");
        view.displayProcessingPaymentView();
        
        // wait 5 seconds to simulate processing...
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.view.hideProcessingPaymentView();
            self?.view.displayPaymentSuccessView();
        }
    }
    
    
}
