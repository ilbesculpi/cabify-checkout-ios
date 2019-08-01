//
//  PaymentContracts.swift
//  Cabify Checkout
//
//  Define the UI contracts for the Payment Screen.
//

import Foundation

protocol PaymentViewContract : BaseViewContract {
    
    var presenter: PaymentPresenterContract! { get set }
    var router: PaymentRouterContract! { get set }
    
    func displayProcessingPaymentView();
    func hideProcessingPaymentView();
    func displayOperationSuccessView();
    func displayOperationErrorView();
    
}

protocol PaymentPresenterContract : BasePresenterContract {
    
    var view: PaymentViewContract! { get set }
    var amount: Float { get set }
    
    func onViewCreated();
    
}

protocol PaymentRouterContract : BaseRouterContract {
    
    var view: PaymentViewContract! { get set }
    
}
