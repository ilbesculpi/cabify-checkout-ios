//
//  ProductListMocks.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit
import Promises
@testable import Cabify_Checkout

class ProductListMocks {
    
    class ViewController : ProductListViewController {
        
        var displayProductsCalled: Bool = false;
        
        override func displayProducts(_ products: [Product]) {
            displayProductsCalled = true;
            self.products = products;
        }
        
    }
    
    class Presenter : ProductListPresenter {
        
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
    
    class ProductService : Cabify_Checkout.ProductService {
        
        private var products: [Product] = [];
        var fetchProductsCalled: Bool = false;
        
        func returnProducts(_ products: [Product]) {
            self.products = products;
        }
        
        override func fetchProducts() -> Promise<[Product]> {
            fetchProductsCalled = true;
            let promise = Promise<[Product]> { [unowned self] (resolve, reject) in
                return self.products;
            }
            return promise;
        }
        
    }

}
