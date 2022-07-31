//
//  ETHFonts.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/31.
//

import Foundation

extension UIFont {
    
    public enum Label {
        public static let LargeTitleFont = UIFont.systemFont(ofSize: 18)
        public static let titleFont = UIFont.systemFont(ofSize: 16)
        public static let smallTitleFont = UIFont.systemFont(ofSize: 14)
        public static let littleTitleFont = UIFont.systemFont(ofSize: 12)
        public static let miniTitleFont = UIFont.systemFont(ofSize: 10)
    }
    
    public enum Button {
        public static let primaryFont = UIFont.systemFont(ofSize: 16)
        public static let midiumFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        public static let middleFont = UIFont.systemFont(ofSize: 14)
        public static let smallFont = UIFont.systemFont(ofSize: 14)
        public static let headerFont = UIFont.systemFont(ofSize: 12, weight: .medium)
        public static let littleFont = UIFont.systemFont(ofSize: 10, weight: .medium)
    }
    
}
