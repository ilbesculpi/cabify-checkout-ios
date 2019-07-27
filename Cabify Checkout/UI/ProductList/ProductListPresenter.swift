//
//  ProductListPresenter.swift
//  Cabify Checkout
//
//  Handles the behavior of the ProductList Screen.
//

import UIKit
import Promises

class ProductListPresenter: BasePresenter, ProductListPresenterContract {
    
    
    // MARK: - Properties
    weak var view: ProductListViewContract!
    var productRepository: ProductRepository!
    var isLoading: Bool = false;
    
    // MARK: - Initialization
    
    init(view: ProductListViewContract) {
        self.view = view;
    }

    
    // MARK: - ProductListPresenter
    
    func onViewCreated() {
        print("[DEBUG] ProductList::onViewCreated()");
        fetchProducts();
    }
    
    func fetchProducts() {
        
        if isLoading {
            return;
        }
        
        print("[DEBUG] ProductList::fetchProducts()");
        
        view.showLoadingView();
        
        productRepository.fetchProducts()
            .then { [weak self] (products) in
                self?.isLoading = false;
                self?.view.hideLoadingView();
                self?.view.displayProducts(products);
            }
            .catch { [weak self] (error) in
                self?.isLoading = false;
                self?.view.hideLoadingView();
                self?.view.displayError(message: "Failed to retrieve the product list.");
            }
    }
    
}
