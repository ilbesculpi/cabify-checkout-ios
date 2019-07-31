//
//  CartRouter.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/29/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class CartRouter: BaseRouter, CartRouterContract {

    // MARK: - Properties
    weak var view: CartViewContract!
    
    
    // MARK: - Initialization
    
    init(view: CartViewContract) {
        self.view = view;
    }
    
    // MARK: - Router
    
    func displayCheckoutScreen() {
        
        if let checkoutController = UIContainer.app.resolve(CheckoutViewController.self) {
            (view as! UIViewController).navigationController?.pushViewController(checkoutController, animated: true);
        }
        
    }
}
