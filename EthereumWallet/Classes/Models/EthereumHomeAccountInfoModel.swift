//
//  EthereumHomeAccountInfoModel.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/31.
//

import Foundation
import web3

typealias ETHActionModel = EthereumHomeAccountInfoModel.EthereumActionModel

struct EthereumHomeAccountInfoModel {
    let nickName: String
    let wallet: EthereumAccount
    let actionModels: [ETHActionModel]
    
    init(nickName: String, wallet: EthereumAccount, actionModels: [EthereumActionModel]) {
        self.nickName = nickName
        self.wallet = wallet
        self.actionModels = actionModels
    }
}

extension EthereumAccount {
    var addressValue: String {
        return address.value
    }
}

extension EthereumHomeAccountInfoModel {
    
    struct EthereumActionModel {
        let image: UIImage
        let title: String
        let router: EtherenumWalletRouter
        let context: Any
    }
}
