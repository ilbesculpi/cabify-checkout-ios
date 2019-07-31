//
//  RootPresenter.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/31/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class RootPresenter: BasePresenter, RootPresenterContract {

    
    // MARK: - Properties
    weak var view: RootViewContract!
    @objc var cart: ProductCart
    
    
    // MARK: - Initialization
    
    init(view: RootViewContract, cart: ProductCart) {
        self.view = view;
        self.cart = cart;
    }
    
    
    // MARK: - ProductListPresenter
    
    func onViewCreated() {
        print("[DEBUG] RootPresenter::onViewCreated()");
        // Observe cart updates using KVO
        addObserver(self, forKeyPath: #keyPath(cart.updatedAt), options: [.old, .new], context: nil);
        updateView();
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        updateView();
    }
    
    func updateView() {
        view.displayItemCount(cart.itemCount);
    }
    
}
