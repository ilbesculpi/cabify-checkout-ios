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
        
        // Instantiate and configure the ProductList controller
        container.register(ProductListViewController.self) { r in
            let controller = UIStoryboard.Scene.Products.productList;
            controller.presenter = ProductListPresenter(view: controller);
            controller.router = ProductListRouter(view: controller);
            return controller;
        }
        
        return container;
        
    }()

}
