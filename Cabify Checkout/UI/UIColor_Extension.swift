//
//  UIColor_Extension.swift
//  Cabify Checkout
//
//  Provides helper methods for handling UI Colors.
//

import UIKit

extension String {
    
    func substring(_ from: Int) -> String {
        let index = self.index(self.endIndex, offsetBy: from - self.count);
        return String(self[index...]);
    }
    
}

extension UIColor {
    
    enum Scheme {
        
        static let primaryDark = UIColor(hex: "#74BDCB");
        
        static let primaryLight = UIColor(hex: "#E7F2F8");
        
        static let accent = UIColor(hex: "#FFA384");
        
        static let secondary = UIColor(hex: "#EFE7BC");
        
    }
    
}

extension UIColor {
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha:1);
    }
    
    convenience init(hex: String, alpha: CGFloat) {
        
        var hexWithoutSymbol = hex
        
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = hex.substring(1)
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt:UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        
        var r:UInt32!, g:UInt32!, b:UInt32!
        switch (hexWithoutSymbol.count) {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break;
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
            break;
        default:
            // Error: Return #000000
            r = 0x00
            g = 0x00
            b = 0x00
            break;
        }
        
        self.init(
            red: (CGFloat(r)/255),
            green: (CGFloat(g)/255),
            blue: (CGFloat(b)/255),
            alpha:alpha
        );
        
    }
    
}
