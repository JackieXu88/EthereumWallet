//
//  Bundle+Kits.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation

private let kBundle = "bundle"



extension Bundle {
    
    static func bundle(with bundleClass: AnyClass) -> Bundle {
        let className = String(describing: bundleClass)
        let path = Bundle(for: bundleClass).path(forResource: className, ofType: kBundle) ?? ""
        return Bundle(path: path) ?? Bundle.main
    }
    
}
