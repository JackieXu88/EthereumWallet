//
//  UIColor.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation


public struct ColorRGB {
    ///
    public var red = 0
    ///
    public var green = 0
    ///
    public var blue = 0
    ///
    public var alpha: CGFloat = 1
    ///
    public var r255: CGFloat {
        return CGFloat(red)
    }

    ///
    public var g255: CGFloat {
        return CGFloat(green)
    }

    ///
    public var b255: CGFloat {
        return CGFloat(blue)
    }
}

/// Enhanced features of UIColor class is implemented in this extension
public extension UIColor {
    /// two UIColor add
    static func + (lhs: UIColor, rhs: UIColor) -> UIColor {
        return UIColor.eth_color(r255: lhs.rgb.r255 + rhs.rgb.r255,
                                 g255: lhs.rgb.g255 + rhs.rgb.g255,
                                 b255: lhs.rgb.b255 + rhs.rgb.b255)
    }
    /// generate UIColor from rgb Int value
    ///
    static func eth_color(R: Int, G: Int, B: Int, alpha: CGFloat = 1.0) -> UIColor {
        assert(R >= 0 && R <= 255, "Invalid red component")
        assert(G >= 0 && G <= 255, "Invalid green component")
        assert(B >= 0 && B <= 255, "Invalid blue component")
        
        return UIColor(red: CGFloat(R) / 255.0, green: CGFloat(G) / 255.0, blue: CGFloat(B) / 255.0, alpha: alpha)
    }
    
    /// generate UIColor from rgb float Int value
    static func eth_color(r255: CGFloat, g255: CGFloat, b255: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r255 / 255.0, green: g255 / 255.0, blue: b255 / 255.0, alpha: alpha)
    }
    
    /// generate UIColor from hex value
    ///
    static func eth_color(hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor.eth_color(
            R: (hex >> 16) & 0xFF,
            G: (hex >> 8) & 0xFF,
            B: hex & 0xFF,
            alpha: alpha
        )
    }
    
    /// generate UIColor from hex string value
    ///
    static func eth_color(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor.eth_color(hex: Int(rgbValue))
    }
    
    /// Color RGB Tuple
    var rgb: ColorRGB {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return ColorRGB(red: Int(red * 255), green: Int(green * 255), blue: Int(blue * 255), alpha: alpha)
    }
    
    /// Inverse Color
    var eth_inverseColor: UIColor {
        var red: CGFloat = 255.0
        var green: CGFloat = 255.0
        var blue: CGFloat = 255.0
        var alpha: CGFloat = 1.0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        red = 1.0 - red
        green = 1.0 - green
        blue = 1.0 - blue
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

///
public extension UIColor {
    /// generate dynamic color from params light color and dark color
    static func eth_dynamicColor(ofLightColor lightColor: UIColor, andDarkColor darkColor: UIColor) -> UIColor {
        let dynamicColor = UIColor(dynamicProvider: { traitCollection in
            if traitCollection.userInterfaceStyle == UIUserInterfaceStyle.dark {
                return darkColor
            } else {
                return lightColor
            }
        })
        return dynamicColor
    }
}
