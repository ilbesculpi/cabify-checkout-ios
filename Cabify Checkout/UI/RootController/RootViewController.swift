//
//  RootViewController.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/30/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController, RootViewContract {
    
    
    // MARK: - Properties
    var presenter: RootPresenterContract!
    
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad();
        presenter.onViewCreated();
    }
    
    func displayItemCount(_ count: Int) {
        // Update badge
        if( count == 0 ) {
            tabBar.items?[1].badgeValue = nil;
        }
        else {
            tabBar.items?[1].badgeValue = String(count);
        }
    }

}
