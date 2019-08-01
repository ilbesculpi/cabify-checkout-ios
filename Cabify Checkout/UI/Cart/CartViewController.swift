//
//  CartViewController.swift
//  Cabify Checkout
//
//  Display the Shopping Cart screen
//

import UIKit

class CartViewController: BaseViewController, CartViewContract {

    
    // MARK: - Properties
    var presenter: CartPresenterContract!
    var router: CartRouterContract!
    
    var cartItems: [ProductCartItem]? {
        didSet {
            tableView.reloadData();
        }
    }
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelTotalUnits: UILabel!
    @IBOutlet weak var labelTotalPrice: UILabel!
    @IBOutlet weak var totalsView: UIView!
    @IBOutlet weak var buttonProceedToCheckout: UIButton!
    @IBOutlet weak var emptyCartView: UIView!
    
    
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
        
    }
    
    
    // MARK: - CartViewContract
    
    func displayCart() {
        totalsView.isHidden = false;
        tableView.isHidden = false;
        buttonProceedToCheckout.isHidden = false;
        emptyCartView.isHidden = true;
    }
    
    func displayEmptyCart() {
        totalsView.isHidden = true;
        tableView.isHidden = true;
        buttonProceedToCheckout.isHidden = true;
        emptyCartView.isHidden = false;
    }
    
    func displayTotal(price: Float) {
        labelTotalPrice.text = String.format(amount: price, currency: currency);
    }
    
    func displayItemCount(_ count: Int) {
        // Update label
        labelTotalUnits.text = "Total (\(count)) items:";
    }
    
    func displayCartItems(_ items: [ProductCartItem]) {
        self.cartItems = items;
    }
    
    func displayCheckoutScreen() {
        router.displayCheckoutScreen();
    }
    
    func setCheckoutState(enabled: Bool) {
        buttonProceedToCheckout.isEnabled = enabled;
    }
    
    
    // MARK: - IBAction
    
    @IBAction func proceedToCheckout(_ sender: UIButton) {
        presenter.performCheckout();
    }

}


// MARK: - UITableView

extension CartViewController: UITableViewDataSource, UITableViewDelegate {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the product to display
        guard let product = cartItems?[indexPath.row] else {
            fatalError("The product to display is not available");
        }
        
        let cellIdentifier = product.hasPromotion ? "ProductCartItemPromotion" : "ProductCartItem";
        
        // Ask the tableView to provide a cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CartProductItemCell else {
            fatalError("The dequeued cell is not an instance of CartProductItemCell");
        }
        
        // Ask the cell to display the product
        cell.delegate = presenter;
        cell.display(product);
        
        // Return the cell
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Get the product to display
        guard let product = cartItems?[indexPath.row] else {
            return 140;
        }
        
        return product.hasPromotion ? 180.0 : 148.0;
    }
    
}
