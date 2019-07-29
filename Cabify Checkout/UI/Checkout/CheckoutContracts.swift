//
//  CheckoutContracts.swift
//  Cabify Checkout
//
//  Define the UI contracts for the Checkout Screen.
//

import Foundation

protocol CheckoutViewContract : BaseViewContract {
    
    var presenter: CheckoutPresenterContract! { get set }
    var router: CheckoutRouterContract! { get set }
    
}

protocol CheckoutPresenterContract : BasePresenterContract {
    
    var view: CheckoutViewContract! { get set }
    
    func onViewCreated()
    
}

protocol CheckoutRouterContract : BaseRouterContract {
    
    var view: CheckoutViewContract! { get set }
    
}
