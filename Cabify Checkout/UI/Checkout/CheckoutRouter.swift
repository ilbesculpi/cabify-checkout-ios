//
//  CheckoutRouter.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/29/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class CheckoutRouter: BaseRouter, CheckoutRouterContract {

    // MARK: - Properties
    weak var view: CheckoutViewContract!
    
    
    // MARK: - Initialization
    
    init(view: CheckoutViewContract) {
        self.view = view;
    }
    
    // MARK: - CheckoutRouterContract
    
    func displayPaymentScreen() {
        if let paymentController = UIContainer.app.resolve(PaymentViewController.self) {
            let navigation = embedInNavigation(paymentController);
            (view as! UIViewController).navigationController?
                .present(navigation, animated: true, completion: nil);
        }
    }
    
}
