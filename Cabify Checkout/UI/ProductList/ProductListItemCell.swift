//
//  ProductListItemCell.swift
//  Cabify Checkout
//
//  Displays a single Product on the Product List
//

import UIKit

class ProductListItemCell: UITableViewCell {
    
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var buttonAdd: UIButton!

    
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // MARK: - Display

    /**
     Display a single Product on the cell.
    */
    func display(_ product: Product) {
        
        labelCode.text = product.code;
        labelTitle.text = product.name;
        
        let formatter = NumberFormatter();
        //formatter.locale = Locale(identifier: "es_ES");
        formatter.numberStyle = .currency;
        formatter.currencySymbol = "€";
        formatter.decimalSeparator = ".";
        formatter.maximumFractionDigits = 2;
        labelPrice.text = formatter.string(from: NSNumber(value: product.price));
    }

}
