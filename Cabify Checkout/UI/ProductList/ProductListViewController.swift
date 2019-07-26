//
//  ProductListViewController.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController, ProductListViewContract {

    
    // MARK: - Properties
    var presenter: ProductListPresenterContract!
    var router: ProductListRouterContract!
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad();
        presenter.onViewCreated();
    }
    
    
    // MARK: - ProductListViewContract
    
    func displayProducts(_ products: [Product]) {
        
    }
    

}
