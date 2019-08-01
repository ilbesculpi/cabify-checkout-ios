//
//  BaseContracts.swift
//  Cabify Checkout
//
//  Define the UI contracts shared between main views
//

import UIKit

protocol BaseViewContract : class {
    
    func showLoadingView();
    func hideLoadingView();
    func displayError(message: String);
    
}

protocol BasePresenterContract : class {
    
}

protocol BaseRouterContract : class {
    
    func embedInNavigation(_ controller: UIViewController) -> UINavigationController
    
}

