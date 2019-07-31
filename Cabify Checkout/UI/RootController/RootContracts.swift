//
//  RootContracts.swift
//  Cabify Checkout
//
//  Define the UI contracts for the Root Controller (TabBar)
//

import Foundation

protocol RootViewContract : class {
    
    var presenter: RootPresenterContract! { get set }
    
    func displayItemCount(_ count: Int);
    
}

protocol RootPresenterContract : BasePresenterContract {
    
    var view: RootViewContract! { get set }
    var cart: ProductCart { get set }
    
    func onViewCreated()
    
}

