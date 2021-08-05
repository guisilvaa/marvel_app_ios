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
    
    @nonobjc class var blue: UIColor {
        return UIColor(red: 0.0, green: 67.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var turquoiseGreen: UIColor {
        return UIColor(red: 0.0, green: 1.0, blue: 141.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var bluePurple: UIColor {
        return UIColor(red: 82.0 / 255.0, green: 10.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var pumpkinOrange: UIColor {
        return UIColor(red: 1.0, green: 116.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var marigold: UIColor {
        return UIColor(red: 1.0, green: 197.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var veryLightPink: UIColor {
        return UIColor(white: 204.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var greyishBrown: UIColor {
        return UIColor(white: 80.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var cherryRed: UIColor {
        return UIColor(red: 1.0, green: 0.0, blue: 40.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var red: UIColor {
        return UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var brownGrey: UIColor {
        return UIColor(white: 151.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var whitee: UIColor {
        return UIColor(white: 246.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var veryLightPinkFour: UIColor {
        return UIColor(white: 196.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var trueBlue: UIColor {
        return UIColor(red: 0.0, green: 52.0 / 255.0, blue: 182.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var pinkRed: UIColor {
        return UIColor(red: 225.0 / 255.0, green: 36.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var dullOrange: UIColor {
        return UIColor(red: 226.0 / 255.0, green: 123.0 / 255.0, blue: 49.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var purpleBlue: UIColor {
        return UIColor(red: 73.0 / 255.0, green: 38.0 / 255.0, blue: 231.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var sunflowerYellow: UIColor {
        return UIColor(red: 1.0, green: 230.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var veryLightPinkFive: UIColor {
        return UIColor(white: 242.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var bluePurpleTwo: UIColor {
      return UIColor(red: 80.0 / 255.0, green: 13.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var uglyYellow: UIColor {
      return UIColor(red: 204.0 / 255.0, green: 209.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var marineBlue: UIColor {
       return UIColor(red: 0.0, green: 32.0 / 255.0, blue: 115.0 / 255.0, alpha: 1.0)
     }
    
    @nonobjc class var brightYellow: UIColor {
      return UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
    }
}
