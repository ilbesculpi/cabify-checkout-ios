//
//  CheckoutItemCell.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/31/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class CheckoutItemCell: UITableViewCell {
    
    
    // MARK: - Properties
    var currency: String = Environment.currencySymbol
    
    // MARK: - IBOutlet
    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelQuantity: UILabel!
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
            let savings = String.format(amount: product.savings, currency: currency);
            labelPromotionSaves.text = String(format: "You save: %@".localized(), savings);
        }
        else {
            labelPromotionSaves.text = nil;
        }
        
    }

}
