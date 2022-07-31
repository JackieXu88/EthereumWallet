//
//  Kits.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation
import UIKit

extension Bundle {
    static var bundle = Bundle.bundle(with: EthereumWallet.self)
}

extension String {
    
    public var localized: String {
        return localized(inBundle: Bundle.bundle)
    }
    
}

public extension UICollectionView {
    enum SupplementaryViewType: String {
        case header = "CollectionViewHeader"
    }

    func register<T: UICollectionViewCell>(cellClasses: [T.Type]) {
        cellClasses.forEach(register)
    }

    func register<T: UICollectionViewCell>(cellClass: T.Type) {
        register(cellClass,
                 forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }

    func register<T: UIView>(supplementaryHeaderClass: T.Type) {
        register(supplementaryHeaderClass,
                 forSupplementaryViewOfKind: SupplementaryViewType.header.rawValue,
                 withReuseIdentifier: String(describing: supplementaryHeaderClass))
    }

    func dequeue<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(T.reuseIdentifier) from collection view.")
        }

        return cell
    }

    func dequeue<T: UIView>(supplementaryViewType: SupplementaryViewType, indexPath: IndexPath) -> T {
        guard let supplementaryView = dequeueReusableSupplementaryView(ofKind: supplementaryViewType.rawValue,
                                                                       withReuseIdentifier: String(describing: T.self),
                                                                       for: indexPath) as? T
        else {
            fatalError("Unable to dequeue supplementaryView \(String(describing: T.self)) of type \(supplementaryViewType.rawValue).")
        }

        return supplementaryView
    }
}

public extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

public enum NextUIEvent {
    case failed(message: String)
    case success(message: String)
    case showLoading
    case endRefresh
}

extension UIImage {
    
    static func image(named name: String?) -> UIImage {
        let emptyImage = UIImage.makeImage(from: .clear)
        guard let name = name else {
            return emptyImage
        }
        return UIImage(named: name, in: Bundle.bundle, compatibleWith: nil) ?? emptyImage
    }
    
}
