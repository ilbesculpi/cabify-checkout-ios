//
//  BaseContracts.swift
//  Cabify Checkout
//
//  Define the UI contracts shared between main views
//

import Foundation

protocol BaseViewContract : class {
    
    func showLoadingView();
    func hideLoadingView();
    func displayError(message: String);
    
}

protocol BasePresenterContract : class {
    
}

protocol BaseRouterContract : class {
    
}

