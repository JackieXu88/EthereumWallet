//
//  EthereumImages.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation

enum EthereumImages {
    
    enum Common: String, EthereumAssetsProtocol {
        case networkError = "icon_network_error"
    }
    
    enum Home: String, EthereumAssetsProtocol {
        case receive = "icon_receive"
        case buy = "icon_buy"
        case send = "icon_send"
        case share = "icon_share"
    }
    
}

protocol EthereumAssetsProtocol: CaseIterable, RawRepresentable {
    var image: UIImage { get }
}

extension EthereumAssetsProtocol {
    var image: UIImage {
        return UIImage.image(named: rawValue as? String)
    }
}
