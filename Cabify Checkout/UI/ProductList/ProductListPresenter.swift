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
    var cart: ProductCart;
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                self.view.showLoadingView();
            }
            else {
                self.view.hideLoadingView();
            }
        }
    }
    
    
    // MARK: - Initialization
    
    init(view: ProductListViewContract, cart: ProductCart) {
        self.view = view;
        self.cart = cart;
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
        
        isLoading = true;
        
        productRepository.fetchProducts()
            .then { [weak self] (products) in
                self?.isLoading = false;
                self?.view.displayProducts(products);
            }
            .catch { [weak self] (error) in
                self?.isLoading = false;
                self?.view.displayError(message: "Failed to retrieve the product list.");
            }
    }
    
    func addProduct(product: Product) {
        print("[DEBUG] ProductList::addProduct(\(product.code))");
        cart.addProduct(product);
    }
    
}
