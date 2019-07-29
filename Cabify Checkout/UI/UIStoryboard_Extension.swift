//
//  UIStoryboard_Extension.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit


extension UIStoryboard {
    
    enum Scene {
        
        enum Products {
            
            static let storyboard = UIStoryboard(name: "Products", bundle: nil);
            
            static var productList : ProductListViewController {
                return storyboard.instantiateViewController(withIdentifier: "ProductList") as! ProductListViewController;
            }
            
            static var checkout : CheckoutViewController {
                return storyboard.instantiateViewController(withIdentifier: "Checkout") as! CheckoutViewController;
            }
            
        }
        
    }
    
}
