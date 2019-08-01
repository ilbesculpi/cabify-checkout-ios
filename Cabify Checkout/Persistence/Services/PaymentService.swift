//
//  PaymentService.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 8/1/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import Foundation
import Promises

class PaymentService: PaymentRepository {
    
    func processPayment(amount: Float, completion: @escaping(Result<Bool, PaymentError>) -> Void) {
        
        // wait 4 seconds to simulate processing...
        let waitTime = 4.0
        DispatchQueue.main.asyncAfter(deadline: .now() + waitTime) {
            let result = Result<Bool, PaymentError>.success(true)
            completion(result)
        }
        
    }

}
