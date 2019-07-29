//
//  CartService.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/28/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import Foundation
import Promises

class CartService: CartRepository {
    
    struct Promotion : Codable {
        
        var code: String;
        var type: String;
        var name: String;
        var quantity: Int;
        var price: Float?
        var paid: Int?
        
    }
    
    /**
     Get the list of promotions stored on the device.
     The promotions are stored on a single file called 'Promotions.plist'.
    */
    func loadPromotions() -> Promise<[ProductCart.Discount]> {
        
        let promise = Promise<[ProductCart.Discount]> { (resolve, reject) in
            
            guard let fileUrl = Bundle.main.url(forResource: "Promotions", withExtension: "plist") else {
                print("[ERROR] Error loading Promotions.plist");
                reject(CartError.loadPromotionsError);
                return;
            }
            
            // Load Promotions plist file
            do {
                let data = try Data(contentsOf: fileUrl);
                let decoder = PropertyListDecoder();
                
                let localPromotions = try decoder.decode([Promotion].self, from: data)
                var promotions: [ProductCart.Discount] = [];
                
                for item in localPromotions {
                    
                    do {
                        let discount = try self.getDiscount(from: item);
                        promotions.append(discount);
                    }
                    catch {
                        print("[WARN] Invalid promotion: \(item.name): \(error.localizedDescription)")
                    }
                }
                
                resolve(promotions);
                
            }
            catch {
                print("[ERROR] Error decoding plist file: \(error.localizedDescription)");
                reject(CartError.loadPromotionsError);
            }
        }
        
        return promise;
    }
    
    private func getDiscount(from item: Promotion) throws -> ProductCart.Discount {
        
        if item.type.lowercased() == "combo" {
            
            guard let paidItems = item.paid else {
                // Combo promotions should define quantity and paid items
                let error = NSError(domain: "Invalid promotion", code: 4001, userInfo: nil);
                throw error;
            }
            
            let freeItems = item.quantity - paidItems;
            let promoType = ProductCart.DiscountType.combo(quantity: item.quantity, free: freeItems);
            let promotion = ProductCart.Discount(name: item.name, code: item.code, type: promoType);
            return promotion;
        }
        
        if item.type.lowercased() == "bulk" {
            
            guard let price = item.price else {
                // Bulk promotions should define quantity and price
                let error = NSError(domain: "Invalid promotion", code: 4002, userInfo: nil);
                throw error;
            }
            
            let promoType = ProductCart.DiscountType.bulk(quantity: item.quantity, price: price);
            let promotion = ProductCart.Discount(name: item.name, code: item.code, type: promoType);
            return promotion;
        }
        
        // unknown promotion
        let error = NSError(domain: "Unkown promotion", code: 4003, userInfo: nil);
        throw error;
    }

}
