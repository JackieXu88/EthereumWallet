//
//  EthereumNetwork.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation
import web3

struct EthereumNetwork {
    
    static var client = EthereumClient(url: Config.hostUrl)
    
}

extension EthereumNetwork {
    struct Config {
        static let host = "https://eth-mainnet.g.alchemy.com/v2"
        static let key = "EUuK-8tBdzFBokREMdY7tQuGk8NQ_XJn"
        
        static var hostUrl: URL {
            return URL(string: "\(host)/\(key)")!
        }
    }
}
