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
    weak var delegate: CartListItemDelegate?
    var currency: String = Environment.currencySymbol
    
    // MARK: - IBOutlet
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelQuantity: UILabel!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonRemove: UIButton!
    @IBOutlet weak var labelPromotion: UILabel!
    @IBOutlet weak var labelPromotionSaves: UILabel!
    
    
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
        
        let unitPrice = String.format(amount: product.unitPrice, currency: currency);
        labelQuantity.text = "\(product.quantity) x \(unitPrice)";
        
        let totalPrice = String.format(amount: product.totalPrice, currency: currency);
        labelPrice.text = totalPrice;
        
        // item has promotion?
        if product.hasPromotion {
            let discountPrice = String.format(amount: product.discountPrice, currency: currency);
            labelQuantity.text = "\(product.quantity) x \(discountPrice)";
            labelPromotion.text = product.promotion;
            let savings = String.format(amount: product.savings, currency: currency);
            labelPromotionSaves.text = String(format: "You save: %@".localized(), savings);
        }
    }
    
    
    // MARK: - IBAction
    
    @IBAction func productAction(_ sender: UIButton) {
        
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
        
        if sender == buttonAdd {
            delegate?.increaseProduct(self.product);
        }
        else if sender == buttonMinus {
            delegate?.decreaseProduct(self.product);
        }
        else if sender == buttonRemove {
            delegate?.removeProduct(self.product);
        }
        
    }
    
    
}



protocol CartListItemDelegate : class {
    
    func increaseProduct(_ product: ProductCartItem);
    func decreaseProduct(_ product: ProductCartItem);
    func removeProduct(_ product: ProductCartItem);
    
}
