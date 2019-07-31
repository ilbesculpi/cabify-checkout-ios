//
//  CartMocks.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/31/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit
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
    
}
