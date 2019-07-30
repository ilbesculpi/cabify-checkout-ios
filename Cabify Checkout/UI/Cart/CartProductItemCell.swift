//
//  CartProductItemCell.swift
//  Cabify Checkout
//
//  Displays a single added Product to the shopping cart.
//

import UIKit

class CartProductItemCell: UITableViewCell {
    
    
    // MARK: - Properties
    private var product: ProductCartItem!

    
    // MARK: - IBOutlet
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelQuantity: UILabel!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonRemove: UIButton!
    
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    
    // MARK: - Display
    
    /**
     Display a single Product.
     */
    func display(_ product: ProductCartItem) {
        
        self.product = product;
        
        labelCode.text = product.code;
        labelTitle.text = product.name;
        
        let unitPrice = String.format(amount: product.price, currency: "€");
        labelQuantity.text = "\(product.quantity) x \(unitPrice)";
        
        let totalPrice = String.format(amount: product.totalPrice, currency: "€");
        labelPrice.text = totalPrice;
    }
    
}
