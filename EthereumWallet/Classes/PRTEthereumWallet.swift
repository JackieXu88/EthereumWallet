//
//  EthereumWallet.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation

public class EthereumWallet {
    
    public init() {
        EtherenumWalletRouter.regist()
        debugPrint("xxxx")
    }
    
    public var rootViewController: UIViewController {
        guard let rootViewController = EthereumRouter.default.viewController(for: EtherenumWalletRouter.createWallet.urlPattern) else {
            return UIViewController()
        }
        return rootViewController
    }
}
