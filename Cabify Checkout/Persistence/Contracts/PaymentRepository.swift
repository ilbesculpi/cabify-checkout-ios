//
//  PaymentRepository.swift
//  Cabify Checkout
//
//  Define Payments public interface
//

import Foundation


enum PaymentError : Error {
    
    case insufficientFunds
    case unknown
    
}

protocol PaymentRepository {
    
    func processPayment(amount: Float, completion: @escaping(Result<Bool, PaymentError>) -> Void)
    
}
