//
//  BaseViewController.swift
//  Cabify Checkout
//
//  Defines basic ViewController behavior
//

import UIKit

class BaseViewController: UIViewController, BaseViewContract {

    
    // MARK: - Properties
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate;
    }
    
    var rootController: RootViewController {
        return appDelegate.window?.rootViewController as! RootViewController;
    }
    
    var currency: String = Environment.currencySymbol;
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    
    // MARK: - BaseViewContract
    
    func showLoadingView() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
    }
    
    func hideLoadingView() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false;
    }
    
    func displayError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert);
        alert.addAction(UIAlertAction(
            title: "Dismiss".localized(),
            style: .default,
            handler: nil
        ));
        present(alert, animated: false, completion: nil);
    }
    
}
