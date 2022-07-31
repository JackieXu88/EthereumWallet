//
//  EthereumAccountModel.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation
import web3

struct EthereumAccountModel {
    let accountName: String
    let accountPassword: String
    let wallet: EthereumAccount
}
