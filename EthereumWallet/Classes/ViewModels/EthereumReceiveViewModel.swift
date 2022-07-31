//
//  EthereumReceiveViewModel.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/31.
//

import Foundation
import web3
import RxSwift
import RxCocoa
import UIKit

struct EthereumReceiveViewModel {
    let walletAccount = BehaviorRelay<EthereumAccount?>(value: nil)
    
    var context: Any? {
        didSet {
            if let context = context as? EthereumAccount {
                self.walletAccount.accept(context)
            }
        }
    }
    
}

extension EthereumAccount {
    var qrImage: UIImage? {
        return self.addressValue.qrCodeImage
    }
}
