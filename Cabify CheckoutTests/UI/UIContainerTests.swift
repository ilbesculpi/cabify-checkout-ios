//
//  UIContainerTests.swift
//  Cabify CheckoutTests
//
//  Created by Ilbert Esculpi on 7/27/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import XCTest
import Swinject
@testable import Cabify_Checkout

class UIContainerTests: XCTestCase {

    var container: Container!
    
    override func setUp() {
        container = UIContainer.container;
    }

    override func tearDown() {
        container = nil;
    }

    func testProductListDependencies() {
        
        guard let controller = container.resolve(ProductListViewController.self) else {
            XCTFail("Unable to instantiate ProductList controller");
            return;
        }
        
        XCTAssertNotNil(controller.presenter, "container should provide a presenter");
        XCTAssertNotNil(controller.router, "container should provide a router");
        
        XCTAssertNotNil(controller.presenter.view, "container should wire presenter's view");
        XCTAssertNotNil(controller.presenter.productRepository, "container should provide a repository");
        
    }

}
