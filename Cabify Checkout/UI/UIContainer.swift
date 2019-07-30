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
    
    static var container: Container = {
        
        let container = Container();
        
        // Configure Repositories
        container.register(ProductRepository.self) { r in
            return ProductService();
        }
        
        container.register(CartRepository.self) { r in
            return CartService();
        }
        
        // Instantiate and configure the RootViewController
        container.register(UITabBarController.self) { r in
            
            let tabController = UIStoryboard.Scene.App.tabController;
            
            let productListController = r.resolve(ProductListViewController.self)!
            let cartController = r.resolve(CartViewController.self)!
            
            let tab0 = embedInNavigation(productListController);
            let tab1 = embedInNavigation(cartController);
            
            tabController.viewControllers = [tab0, tab1];
            return tabController;
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
    
    class func embedInNavigation(_ controller: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: controller);
    }

}
