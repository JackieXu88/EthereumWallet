//
//  EtherenumWalletRouter.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation

enum EtherenumWalletRouter: String, EthereumRouterProtocol {
    
    case home = "EtherenumHomeViewController"
    case createWallet = "EthereumCreateViewController"
    case receive = "EthereumReceiveViewController"
    case buy = "EthereumBuyViewController"
    case send = "EthereumSendViewController"
    
    var controller: UIViewController? {
        switch self {
        case .home:
            return EtherenumHomeViewController(viewModel: ETHCollectionViewModel())
        case .createWallet:
            return EthereumCreateViewController()
        case .receive:
            return EthereumReceiveViewController()
        case .send, .buy:
            return UIViewController()
        }
    }
    
}
