//
//  CheckoutViewController.swift
//  Cabify Checkout
//
//  Display the checkout screen
//

import UIKit

class CheckoutViewController: BaseViewController, CheckoutViewContract {
    
    
    // MARK: - Properties
    var presenter: CheckoutPresenterContract!
    var router: CheckoutRouterContract!
    
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad();
    }

}
