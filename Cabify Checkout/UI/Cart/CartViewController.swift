//
//  CartViewController.swift
//  Cabify Checkout
//
//  Display the cart screen
//

import UIKit

class CartViewController: BaseViewController, CartViewContract {

    
    // MARK: - Properties
    var presenter: CartPresenterContract!
    var router: CartRouterContract!
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }

}
