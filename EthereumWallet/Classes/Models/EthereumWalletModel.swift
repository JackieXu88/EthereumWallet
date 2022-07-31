//
//  EthereumWalletModel.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/31.
//

import Foundation

enum EthereumSectionType {
    case account
    case tokens
}

enum EthereumItemType {
    case account(model: EthereumHomeAccountInfoModel)
    case token(model: EthereumTokenModel)
}

struct EthereumCollectionSection: Hashable {
    let sectionType: EthereumSectionType
}

struct EthereumCollectionItem: ETHHashableProtocol {
    let identifier: UUID = UUID()
    let itemType: EthereumItemType
}

public protocol ETHHashableProtocol: Hashable {
    var identifier: UUID { get }
}

public extension ETHHashableProtocol {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
