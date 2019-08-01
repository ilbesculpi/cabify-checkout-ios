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
    
    static var app: Container = {
        
        let container = Container();
        
        // Shopping Cart
        container.register(ProductCart.self) { r in
            if let service = r.resolve(CartRepository.self) {
                return service.defaultCart;
            }
            return ProductCart();
        }
        
        // Configure Repositories
        
        container.register(ProductRepository.self) { r in
            return ProductService();
        }
        
        container.register(CartRepository.self) { r in
            return CartService();
        }
        
        container.register(PaymentRepository.self) { r in
            return PaymentService();
        }
        
        // Instantiate and configure the RootViewController
        container.register(RootViewController.self) { r in
            
            let cart = r.resolve(ProductCart.self)!
            let tabController = UIStoryboard.Scene.App.root;
            let presenter = RootPresenter(view: tabController, cart: cart);
            tabController.presenter = presenter;
            
            let productListController = r.resolve(ProductListViewController.self)!
            let cartController = r.resolve(CartViewController.self)!
            
            let tab0 = embedInNavigation(productListController);
            let tab1 = embedInNavigation(cartController);
            
            tabController.viewControllers = [tab0, tab1];
            
            // set tab items
            tabController.tabBar.items?[0].image = UIImage(named: "browse_icon");
            tabController.tabBar.items?[1].image = UIImage(named: "cart_icon");
            return tabController;
        }
        
        // Instantiate and configure the ProductList controller
        container.register(ProductListViewController.self) { r in
            
            let controller = UIStoryboard.Scene.Products.productList;
            controller.router = ProductListRouter(view: controller);
            
            let cart = r.resolve(ProductCart.self)!
            let presenter = ProductListPresenter(view: controller, cart: cart);
            presenter.productRepository = r.resolve(ProductRepository.self);
            controller.presenter = presenter;
            
            return controller;
        }
        
        // Instantiate and configure the Cart controller
        container.register(CartViewController.self) { r in
            
            let controller = UIStoryboard.Scene.Products.cart;
            controller.router = CartRouter(view: controller);
            
            let cart = r.resolve(ProductCart.self)!
            let presenter = CartPresenter(view: controller, cart: cart);
            presenter.cartService = r.resolve(CartRepository.self);
            controller.presenter = presenter;
            
            return controller;
        }
        
        // Instantiate and configure the Checkout controller
        container.register(CheckoutViewController.self) { r in
            
            let controller = UIStoryboard.Scene.Products.checkout;
            controller.router = CheckoutRouter(view: controller);
            
            let cart = r.resolve(ProductCart.self)!
            let presenter = CheckoutPresenter(view: controller, cart: cart);
            controller.presenter = presenter;
            
            return controller;
        }
        
        // Instantiate and configure the Payment controller
        container.register(PaymentViewController.self) { r in
            
            let controller = UIStoryboard.Scene.Payments.payment;
            controller.router = PaymentRouter(view: controller);
            
            let cart = r.resolve(ProductCart.self)!
            let presenter = PaymentPresenter(view: controller, cart: cart, amount: cart.total);
            presenter.paymentService = r.resolve(PaymentRepository.self);
            presenter.cartService = r.resolve(CartRepository.self);
            controller.presenter = presenter;
            
            return controller;
        }
        
        return container;
        
    }()
    
    static var dummy: Container = {
        
        let container = UIContainer.app;
        
        // Override Repositories
        container.register(ProductRepository.self) { r in
            return DummyProductService();
        }
        
        container.register(CartRepository.self) { r in
            return CartService();
        }
        
        return container;
        
    }()
    
    class func embedInNavigation(_ controller: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: controller);
    }

}
