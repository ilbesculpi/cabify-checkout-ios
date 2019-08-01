//
//  BaseRouter.swift
//  Cabify Checkout
//
//  Defines basic Router behavior
//

import UIKit

class BaseRouter: BaseRouterContract {

    func embedInNavigation(_ controller: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: controller);
    }
    
}
