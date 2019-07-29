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
            return true;
        }
    }
    
}
