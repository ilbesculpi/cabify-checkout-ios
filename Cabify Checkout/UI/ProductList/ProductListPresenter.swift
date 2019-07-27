//
//  ProductListPresenter.swift
//  Cabify Checkout
//
//  Handles the behavior of the ProductList Screen.
//

import UIKit
import Promises

class ProductListPresenter: ProductListPresenterContract {
    
    // MARK: - Properties
    weak var view: ProductListViewContract!
    var productRepository: ProductRepository!
    
    
    // MARK: - Initialization
    
    init(view: ProductListViewContract) {
        self.view = view;
    }

    
    // MARK: - ProductListPresenter
    
    func onViewCreated() {
        print("[DEBUG] ProductList::onViewCreated()");
        view.showLoadingView();
        productRepository.fetchProducts()
            .then { [weak self] (products) in
                self?.view.hideLoadingView();
                self?.view.displayProducts(products);
            }
            .catch { [weak self] (error) in
                self?.view.hideLoadingView();
                self?.view.displayError(message: "Failed to retrieve the product list.");
            }
        
    }
    
    func fetchProducts() {
        print("[DEBUG] ProductList::fetchProducts()");
    }
    
}
