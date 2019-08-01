//
//  CheckoutItemCell.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/31/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

class CheckoutItemCell: UITableViewCell {
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelQuantity: UILabel!
    @IBOutlet weak var labelPromotion: UILabel!
    @IBOutlet weak var labelPromotionSaves: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    // MARK: - Display
    
    /**
     Display a single Product.
     */
    func display(_ product: ProductCartItem) {
        
        labelCode.text = product.code;
        labelTitle.text = product.name;
        
        let unitPrice = String.format(amount: product.unitPrice, currency: "€");
        labelQuantity.text = "\(product.quantity) x \(unitPrice)";
        
        let totalPrice = String.format(amount: product.totalPrice, currency: "€");
        labelPrice.text = totalPrice;
        
        // item has promotion?
        if product.hasPromotion {
            let discountPrice = String.format(amount: product.discountPrice, currency: "€");
            labelQuantity.text = "\(product.quantity) x \(discountPrice)";
            //labelPromotion.text = product.promotion;
            let savings = String.format(amount: product.savings, currency: "€");
            labelPromotionSaves.text = "You save: \(savings)";
        }
        else {
            labelPromotionSaves.text = nil;
        }
        
    }

}
