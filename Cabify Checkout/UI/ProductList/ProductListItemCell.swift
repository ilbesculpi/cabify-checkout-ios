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
    private var currency: String = Environment.currencySymbol
    
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
        labelPrice.text = String.format(amount: product.price, currency: currency)
    }
    
    
    // MARK: - IBAction
    
    @IBAction func addProductTapped(_ sender: UIButton) {
        UIButton.animate(
            withDuration: 0.2,
            animations: {
                sender.transform = CGAffineTransform(scaleX: 1.10, y: 1.10)
                sender.alpha = 0.5
            },
            completion: { finish in
                UIButton.animate(withDuration: 0.2, animations: {
                    sender.transform = CGAffineTransform.identity
                    sender.alpha = 1.0
                })
            }
        )
        delegate?.didAddProduct(product: self.product);
    }

}

protocol ProductListItemDelegate : class {
    
    func didAddProduct(product: Product)
    
}
