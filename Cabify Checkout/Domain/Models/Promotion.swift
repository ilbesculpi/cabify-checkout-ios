//
//  Promotion.swift
//  Cabify Checkout
//
//  Promotion Model
//

import UIKit

enum PromotionType {
    
    case combo(quantity: Int, free: Int)
    case bulk(quantity: Int, price: Float)
    
}

class Promotion {
    
    var name: String;
    var code: String;
    var type: PromotionType;
    var start: Date?
    var end: Date?
    
    convenience init(name: String, code: String, type: PromotionType) {
        self.init(name: name, code: code, type: type, start: nil, end: nil);
    }
    
    init(name: String, code: String, type: PromotionType, start: Date?, end: Date?) {
        self.name = name;
        self.code = code;
        self.type = type;
        self.start = start;
        self.end = end;
    }
    
    var isActive: Bool {
        get {
            
            if start == nil && end == nil {
                return true;
            }
            
            let current = Date();
            
            if let startDate = start, let endDate = end {
                // if start and end exists, current should be between both
                return (startDate <= current) && (endDate >= current);
            }
            
            if let startDate = start {
                // promotion is active if startDate is in the past
                return startDate <= current;
            }
            
            if let endDate = end {
                // promotion is active if endDate is in the future
                return endDate >= current;
            }
            
            return true;
        }
    }
    
}
