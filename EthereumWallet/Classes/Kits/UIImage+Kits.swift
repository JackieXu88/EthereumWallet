//
//  UIImage+Kits.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation

extension UIImage {
    
    public static func makeImage(from color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
}
