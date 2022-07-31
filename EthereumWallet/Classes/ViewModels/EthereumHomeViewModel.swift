//
//  EthereumHomeViewModel.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/31.
//

import Foundation
import RxSwift
import RxCocoa

typealias WalletCollectionSnapshot = NSDiffableDataSourceSnapshot<EthereumCollectionSection, EthereumCollectionItem>

protocol ETHWalletCollectionViewModelProtocol {
    
    var albumCollectionSnapshot: Observable<WalletCollectionSnapshot> { get }
    
    var context: Any? { get set }
    
    var nextUIEvent: PublishSubject<NextUIEvent> { get }

    
    func viewDidLoad()
    
}

struct ETHCollectionViewModel: ETHWalletCollectionViewModelProtocol {
    
    private let ethCollectionSnapshotObserver = BehaviorRelay<WalletCollectionSnapshot>(value: .init())
    
    let nextUIEvent = PublishSubject<NextUIEvent>()
    
    var albumCollectionSnapshot: Observable<WalletCollectionSnapshot> {
        return ethCollectionSnapshotObserver.asObservable()
    }
    
    var accountModel: EthereumAccountModel?
    
    var context: Any? {
        didSet {
            if let model = context as? EthereumAccountModel {
                accountModel = model
            }
        }
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    func fetchData() {
        getEthBalance { ethNumber, accountModel in
            var snap = WalletCollectionSnapshot()
            let accountSection = EthereumCollectionSection(sectionType: .account)
            let ethTokenSection = EthereumCollectionSection(sectionType: .tokens)
            snap.appendSections([accountSection, ethTokenSection])
            let accountInfoModel = EthereumHomeAccountInfoModel(nickName: accountModel.accountName, wallet: accountModel.wallet, actionModels: generateAccountActions(from: accountModel))
            let accountItem = EthereumCollectionItem(itemType: .account(model: accountInfoModel))
            snap.appendItems([accountItem], toSection: accountSection)
            let ethTokens = EthereumCollectionItem(itemType: .token(model: EthereumTokenModel(tokenNumbers: "\(ethNumber) ETH")))
            snap.appendItems([ethTokens], toSection: ethTokenSection)
            ethCollectionSnapshotObserver.accept(snap)
            nextUIEvent.onNext(.endRefresh)
        }
    }
    
    func generateAccountActions(from accountModel: EthereumAccountModel) ->  [ETHActionModel] {
        return [
            ETHActionModel(image: EthereumImages.Home.receive.image, title: EthereumString.Home.receive.localizedString, router: .receive, context: accountModel.wallet),
            ETHActionModel(image: EthereumImages.Home.buy.image, title: EthereumString.Home.buy.localizedString, router: .buy, context: accountModel.wallet),
            ETHActionModel(image: EthereumImages.Home.send.image, title: EthereumString.Home.send.localizedString, router: .send, context: accountModel.wallet),
        ]
    }
}

extension ETHCollectionViewModel {
    
    func getEthBalance(finished: ((String,EthereumAccountModel) -> Void)? = nil) {
        if let accountModel = accountModel {
            EthereumNetwork.client.eth_getBalance(address: accountModel.wallet.address, block: .Latest) { ethResult in
                switch ethResult {
                case let .failure(error):
                    ETHProgressHud.showErrorHud(with: error.localizedDescription)
                    nextUIEvent.onNext(.endRefresh)
                case let .success(ethNumber):
                    finished?("\(ethNumber)",accountModel)
                }
            }
        }
    }
    
}
