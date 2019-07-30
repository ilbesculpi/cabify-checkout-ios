//
//  CartViewController.swift
//  Cabify Checkout
//
//  Display the cart screen
//

import UIKit

class CartViewController: BaseViewController, CartViewContract {

    
    // MARK: - Properties
    var presenter: CartPresenterContract!
    var router: CartRouterContract!
    
    var products: [ProductCartItem]? {
        didSet {
            tableView.reloadData();
        }
    }
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelTotalUnits: UILabel!
    @IBOutlet weak var labelTotalPrice: UILabel!
    
    
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
        tableView.allowsSelection = false;
        tableView.rowHeight = 148.0;
        
    }
    
    
    // MARK: - CartViewContract
    
    func displayTotal(price: Float) {
        labelTotalPrice.text = String.format(amount: price, currency: "€");
    }
    
    func displayItemCount(_ count: Int) {
        labelTotalUnits.text = "Total (\(count)) items:";
    }
    
    func displayProducts(_ products: [ProductCartItem]) {
        self.products = products;
    }

}


// MARK: - UITableView

extension CartViewController: UITableViewDataSource, UITableViewDelegate {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ProductCartItem";
        
        // Ask the tableView to provide a cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CartProductItemCell else {
            fatalError("The dequeued cell is not an instance of CartProductItemCell");
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
