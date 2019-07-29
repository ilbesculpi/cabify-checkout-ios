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
    
    
    
    // MARK: - Initialization
    
    init(view: CheckoutViewContract) {
        self.view = view;
    }
    
    
    // MARK: - CheckoutPresenter
    
    func onViewCreated() {
        print("[DEBUG] CheckoutPresenter::onViewCreated()");
    }
    
    
}
