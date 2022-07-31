//
//  String+Kits.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation


extension String {
    
    /// String to localized string
    ///
    /// - parameter bundle
    func localized(inBundle bundle: Bundle = Bundle.main, tableName: String? = nil, value: String = "", comment: String = "") -> String {
        NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: comment)
    }

    var qrCodeImage: UIImage? {
        let data = self.data(using: String.Encoding.ascii)
        if let qrFilter = CIFilter(name: "CIQRCodeGenerator") {
            qrFilter.setValue(data, forKey: "inputMessage")
            let tranform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = qrFilter.outputImage?.transformed(by: tranform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
