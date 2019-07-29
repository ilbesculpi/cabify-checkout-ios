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
        
        container.register(CartRepository.self) { r in
            return CartService();
        }
        
        // Instantiate and configure the ProductList controller
        container.register(ProductListViewController.self) { r in
            
            let controller = UIStoryboard.Scene.Products.productList;
            controller.router = ProductListRouter(view: controller);
            
            let presenter = ProductListPresenter(view: controller, cart: CartService.defaultCart);
            presenter.productRepository = r.resolve(ProductRepository.self);
            controller.presenter = presenter;
            
            return controller;
        }
        
        // Instantiate and configure the Cart controller
        container.register(CartViewController.self) { r in
            
            let controller = UIStoryboard.Scene.Products.cart;
            controller.router = CartRouter(view: controller);
            
            let presenter = CartPresenter(view: controller, cart: CartService.defaultCart);
            controller.presenter = presenter;
            
            return controller;
        }
        
        // Instantiate and configure the Checkout controller
        container.register(CheckoutViewController.self) { r in
            
            let controller = UIStoryboard.Scene.Products.checkout;
            controller.router = CheckoutRouter(view: controller);
            
            let presenter = CheckoutPresenter(view: controller);
            //presenter.productRepository = r.resolve(ProductRepository.self);
            controller.presenter = presenter;
            
            return controller;
        }
        
        return container;
        
    }()

}
