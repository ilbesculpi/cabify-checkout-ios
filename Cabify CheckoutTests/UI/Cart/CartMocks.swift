//
//  CartMocks.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/31/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit
import Promises
@testable import Cabify_Checkout

class CartMocks {
    
    class Presenter : CartPresenter {
        
        var onViewCreatedCalled: Bool = false;
        
        override func onViewCreated() {
            onViewCreatedCalled = true;
        }
        
    }

    class TableView : UITableView {
        
        var reloadDataCalled: Bool = false;
        
        override func reloadData() {
            super.reloadData();
            reloadDataCalled = true;
        }
        
    }
    
    class Router : CartRouter {
        
        var displayCheckoutScreenCalled: Bool = false;
        
        override func displayCheckoutScreen() {
            displayCheckoutScreenCalled = true;
        }
        
    }
    
    class CartService : Cabify_Checkout.CartService {
        
        var saveCartCalled: Bool = false;
        
        override func saveCart(_ cart: ProductCart) -> Promise<Void> {
            saveCartCalled = true;
            let promise = Promise<Void>.pending();
            promise.fulfill(());
            return promise;
        }
        
    }
    
}
