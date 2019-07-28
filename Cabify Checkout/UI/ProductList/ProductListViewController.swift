//
//  ProductListViewController.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/26/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class ProductListViewController: BaseViewController, ProductListViewContract {

    
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
    var refreshControl: UIRefreshControl!
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        configureTableView();
        
        presenter.onViewCreated();
        
    }
    
    private func configureTableView() {
        
        tableView.tableFooterView = UIView();
        
        // DataSource & Delegate
        tableView.dataSource = self;
        tableView.delegate = self;
        
        // Cell configuration
        tableView.rowHeight = 112.0;
        //tableView.estimatedRowHeight = 112.0;
        
        // Pull to refresh
        refreshControl = UIRefreshControl();
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged);
        tableView.refreshControl = refreshControl;
    }
    
    
    // MARK: - ProductListViewContract
    
    override func hideLoadingView() {
        super.hideLoadingView();
        refreshControl.endRefreshing();
    }
    
    func displayProducts(_ products: [Product]) {
        self.products = products;
    }
    
    @objc func reload() {
        presenter.fetchProducts();
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
