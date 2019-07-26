//
//  ProductListRouter.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class ProductListRouter: ProductListRouterContract {

    weak var view: ProductListViewContract!
    
    init(view: ProductListViewContract) {
        self.view = view;
    }
    
}
