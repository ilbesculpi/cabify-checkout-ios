//
//  ProductListPresenter.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class ProductListPresenter: ProductListPresenterContract {
    
    weak var view: ProductListViewContract!
    
    var products: [Product] = [
        Product(code: "VOUCHER", name: "Cabify Voucher", price: 5.0),
        Product(code: "TSHIRT", name: "Cabify T-Shirt", price: 20.0),
        Product(code: "MUG", name: "Cabify Coffee Mug", price: 7.5),
    ];
    
    init(view: ProductListViewContract) {
        self.view = view;
    }

    func onViewCreated() {
        print("[DEBUG] ProductList::onViewCreated()");
        view.displayProducts(products);
    }
    
    func fetchProducts() {
        print("[DEBUG] ProductList::fetchProducts()");
    }
    
}
