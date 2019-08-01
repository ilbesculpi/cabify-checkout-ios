//
//  String_Extension.swift
//  Cabify Checkout
//
//  String Helper
//

import Foundation

extension String {
    
    static func format(amount: Float, currency: String) -> String {
        
        let formatter = NumberFormatter();
        //formatter.locale = Locale(identifier: "es_ES");
        formatter.numberStyle = .currency;
        formatter.currencySymbol = currency;
        formatter.decimalSeparator = ".";
        formatter.maximumFractionDigits = 2;
        
        return formatter.string(from: NSNumber(value: amount))!
    }
    
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment);
    }
    
}
