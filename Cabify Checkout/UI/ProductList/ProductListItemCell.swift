//
//  ProductListItemCell.swift
//  Cabify Checkout
//
//  Displays a single Product on the Product List
//

import UIKit

class ProductListItemCell: UITableViewCell {
    
    
    // MARK: - Properties
    weak var delegate: ProductListItemDelegate?
    private var product: Product!
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var buttonAdd: UIButton!

    
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    
    // MARK: - Display

    /**
     Display a single Product on the cell.
    */
    func display(_ product: Product) {
        
        self.product = product;
        
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
    
    
    // MARK: - IBAction
    
    @IBAction func addProductTapped(_ sender: UIButton) {
        delegate?.didAddProduct(product: self.product);
    }

}

protocol ProductListItemDelegate : class {
    
    func didAddProduct(product: Product)
    
}
