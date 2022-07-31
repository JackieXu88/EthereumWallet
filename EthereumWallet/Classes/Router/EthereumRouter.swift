//
//  EtherenumRouter.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation
import URLNavigator

@objcMembers open class EthereumRouter: Navigator {
    /// Default Router, take it as singleton
    public static let `default` = EthereumRouter()
}

public protocol EthereumRouterController: UIViewController {
    func setContext(_ context: Any?)
}

public protocol EthereumRouterProtocol: CaseIterable, RawRepresentable {
    var controller: UIViewController? { get }
    var urlPattern: String { get }
}

extension EthereumRouterProtocol {
    public static func regist() {
        allCases.forEach { item in
            EthereumRouter.default.register(item.urlPattern) {
                let controller = item.controller
                if controller is EthereumRouterController {
                    (controller as? EthereumRouterController)?.setContext($2)
                }
                return controller
            }
        }
    }
}



extension EthereumRouterProtocol where Self.RawValue == String {
    public var urlPattern: String {
        String(describing: Self.self) + "/" + rawValue
    }
}
