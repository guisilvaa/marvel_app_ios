//
//  UIColorExtension.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 05/08/21.
//

import UIKit

extension UIColor {
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(rgbValue: Int, alpha: CGFloat = 1) {
        let r: CGFloat = CGFloat(((rgbValue & 0xFF0000) >> 16) / 0xFF)
        let g: CGFloat = CGFloat((rgbValue & 0x00FF00) >> 8 / 0xFF)
        let b: CGFloat = CGFloat((rgbValue & 0x0000FF) / 0xFF)

        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    @nonobjc class var primaryColor: UIColor {
        return UIColor(red:0.910, green: 0.282, blue: 0.333, alpha: 1.000)
    }
    
    @nonobjc class var lightGrey: UIColor {
        return UIColor(white: 204.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var greyishBrown: UIColor {
        return UIColor(white: 80.0 / 255.0, alpha: 1.0)
    }
    
}
