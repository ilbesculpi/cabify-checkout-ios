//
//  CheckoutViewController.swift
//  Cabify Checkout
//
//  Display the checkout screen
//

import UIKit

class CheckoutViewController: BaseViewController, CheckoutViewContract {
    
    
    // MARK: - Properties
    var presenter: CheckoutPresenterContract!
    var router: CheckoutRouterContract!
    
    var cartItems: [ProductCartItem]? {
        didSet {
            tableView.reloadData();
        }
    }
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var labelSubtotal: UILabel!
    @IBOutlet weak var labelDiscounts: UILabel!
    @IBOutlet weak var buttonPay: UIButton!
    
    
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
        tableView.rowHeight = 108.0;
    }
    
    
    // MARK: - CheckoutViewContract
    
    func displayTotal(price: Float) {
        labelTotal.text = String.format(amount: price, currency: "€");
    }
    
    func displaySubtotal(price: Float) {
        labelSubtotal.text = String.format(amount: price, currency: "€");
    }
    
    func displayDiscounts(price: Float) {
        labelDiscounts.text = "-" + String.format(amount: price, currency: "€");
    }
    
    func displayCartItems(_ items: [ProductCartItem]) {
        self.cartItems = items;
    }

}



// MARK: - UITableView

extension CheckoutViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the product to display
        guard let product = cartItems?[indexPath.row] else {
            fatalError("The product to display is not available");
        }
        
        let cellIdentifier = "CheckoutItemCell";
        
        // Ask the tableView to provide a cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CheckoutItemCell else {
            fatalError("The dequeued cell is not an instance of CheckoutItemCell");
        }
        
        // Ask the cell to display the product
        cell.display(product);
        
        // Return the cell
        return cell;
    }
    
}
