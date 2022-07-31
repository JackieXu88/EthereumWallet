//
//  EthereumCreateWalletViewModel.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation
import RxSwift
import RxCocoa
import web3

struct EthereumCreateWalletViewModel {
    let disposeBag = DisposeBag()
    let accountInput = BehaviorRelay<String>(value: "")
    let passwordInput = BehaviorRelay<String>(value: "")
    let createWalletIsEnable = BehaviorRelay<Bool>(value: false)
    let nextEvent = PublishSubject<NextUIEvent>()
    init() {
        makeBinds()
    }
    
    func makeBinds() {
        let accountAndPasswordSingal = Observable.combineLatest(accountInput, passwordInput)
        accountAndPasswordSingal.map { (accountName, password) -> Bool in
            return (accountName.count > 0) && (password.count > 0)
        }.bind(to: createWalletIsEnable).disposed(by: disposeBag)
    }
    
    func startGenerateWalletWorkFlow() {
        nextEvent.onNext(.showLoading)
        let keyStorage = EthereumKeyLocalStorage()
        if let wallet = try? EthereumAccount.create(keyStorage: keyStorage, keystorePassword: passwordInput.value) {
            let accountModel = EthereumAccountModel(accountName: accountInput.value, accountPassword: passwordInput.value, wallet: wallet)
            nextEvent.onNext(.success(message: EthereumString.CreateAccount.createWalletSuccessed.localizedString))
            loadHomeView(with: accountModel)
        } else {
            nextEvent.onNext(.failed(message: EthereumString.CreateAccount.createWalletFailed.localizedString))
        }
    }
    
    func loadHomeView(with accountModel: EthereumAccountModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            if let homeView = EthereumRouter.default.viewController(for: EtherenumWalletRouter.home.urlPattern, context: accountModel) {
                let nav = UINavigationController(rootViewController: homeView)
                UIApplication.shared.keyWindow?.rootViewController = nav
            }
        }
    }
}
