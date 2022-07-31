//
//  EthereumString.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation

public enum EthereumString {
    
    public enum CreateAccount: String, EthereumStringLocale {
        case accountPlacehold = "ACCOUNT_TEXTFIELD_PLACEHOLDER"
        case passwordPlacehold = "PASSWORD_PLACEHOLDER"
        case generateWalletAddress = "GENERATE_WALLET_ADDRESS"
        case createWalletFailed = "CREATE_WALLET_FAILED"
        case createWalletSuccessed = "CREATE_WALLET_SUCCESSED"
    }
    
    public enum Home: String, EthereumStringLocale {
        case title = "HOME_TITLE"
        case receive = "RECEIVE_TITLE"
        case buy = "BUY_TITLE"
        case send = "SEND_TITLE"
    }
    
    public enum Receive: String, EthereumStringLocale {
        case qrCodeLabelDesc = "QRCODE_DESC"
        case copyTitle = "COPY_TITLE"
        case copySuccess = "COPY_SUCCESSED"
    }
    
    public enum Common: String, EthereumStringLocale {
        case networkError = "NETWORK_ERROR"
    }
}


public protocol EthereumStringLocale: RawRepresentable, CaseIterable {
    var localizedString: String { get }
}

extension EthereumStringLocale {
    public var localizedString: String {
        return (rawValue as? String)?.localized ?? ""
    }
}
