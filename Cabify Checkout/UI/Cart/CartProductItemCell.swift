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
        
        let formatter = NumberFormatter();
        //formatter.locale = Locale(identifier: "es_ES");
        formatter.numberStyle = .currency;
        formatter.currencySymbol = "€";
        formatter.decimalSeparator = ".";
        formatter.maximumFractionDigits = 2;
        if let formattedPrice = formatter.string(from: NSNumber(value: product.price)) {
            labelPrice.text = "\(product.quantity) x \(formattedPrice)";
        }
        else {
            print("[WARN] invalid price for product \(product.code)");
            labelPrice.text = "";
        }
    }
    
}
