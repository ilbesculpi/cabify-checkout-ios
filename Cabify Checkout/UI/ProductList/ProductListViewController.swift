//
//  ProductListViewController.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController, ProductListViewContract {

    
    // MARK: - Properties
    var presenter: ProductListPresenterContract!
    var router: ProductListRouterContract!
    var products: [Product]? {
        didSet {
            tableView.reloadData();
        }
    }
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        configureTableView();
        
        presenter.onViewCreated();
        
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView();
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 112.0;
        //tableView.estimatedRowHeight = 112.0;
    }
    
    
    // MARK: - ProductListViewContract
    
    func showLoadingView() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
    }
    
    func hideLoadingView() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false;
    }
    
    func displayError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert);
        alert.addAction(UIAlertAction(
            title: "Dismiss",
            style: .default,
            handler: nil
        ));
        present(alert, animated: false, completion: nil);
    }
    
    func displayProducts(_ products: [Product]) {
        self.products = products;
    }
    

}

// MARK: - UITableView

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ProductListItem";
        
        // Ask the tableView to provide a cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ProductListItemCell else {
            fatalError("The dequeued cell is not an instance of ProductListItemCell");
        }
        
        // Get the product to display
        guard let product = products?[indexPath.row] else {
            fatalError("The product to display is not available");
        }
        
        // Ask the cell to display the product
        cell.display(product);
        
        // Return the cell
        return cell;
    }
    
}
