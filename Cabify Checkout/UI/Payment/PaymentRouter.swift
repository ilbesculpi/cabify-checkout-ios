//
//  PaymentRouter.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 8/1/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class PaymentRouter: BaseRouter, PaymentRouterContract {

    
    // MARK: - Properties
    weak var view: PaymentViewContract!
    
    
    // MARK: - Initialization
    
    init(view: PaymentViewContract) {
        self.view = view;
    }
    
    
    // MARK: - PaymentViewContract
    
    func dismiss() {
        (view as! UIViewController).navigationController?
            .presentingViewController?
            .dismiss(animated: true, completion: nil)
    }
    
}
