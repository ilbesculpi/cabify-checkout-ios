//
//  UIContainer.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit
import Swinject

final class UIContainer {
    
    static let container: Container = {
        
        let container = Container();
        
        // Configure Repositories
        container.register(ProductRepository.self) { r in
            return ProductService();
        }
        
        // Instantiate and configure the ProductList controller
        container.register(ProductListViewController.self) { r in
            
            let controller = UIStoryboard.Scene.Products.productList;
            controller.router = ProductListRouter(view: controller);
            
            let presenter = ProductListPresenter(view: controller);
            presenter.productRepository = r.resolve(ProductRepository.self);
            controller.presenter = presenter;
            
            return controller;
        }
        
        return container;
        
    }()

}
