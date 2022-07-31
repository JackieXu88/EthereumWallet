//
//  EthereumCreateViewController.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation
import SnapKit
import RxSwift
import RxCocoa

class EthereumCreateViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let viewModel = EthereumCreateWalletViewModel()
    
    private lazy var contentView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.spacing = 20
        contentStackView.axis = .vertical
        return contentStackView
    }()
    
    
    private lazy var accountTextField: UITextField = {
        let accountTextfield = UITextField()
        accountTextfield.placeholder = EthereumString.CreateAccount.accountPlacehold.localizedString
        accountTextfield.textAlignment = .center
        return accountTextfield
    }()
    
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = EthereumString.CreateAccount.passwordPlacehold.localizedString
        passwordTextField.textAlignment = .center
        return passwordTextField
    }()
    
    private lazy var createWalletButton: UIButton = {
        let createWalletButton = UIButton()
        createWalletButton.backgroundColor = .ETHColors.primaryColor
        createWalletButton.setTitle(EthereumString.CreateAccount.generateWalletAddress.localizedString, for: .normal)
        createWalletButton.layer.cornerRadius = 8.0
        createWalletButton.layer.masksToBounds = true
        return createWalletButton
    }()
    
    var contentSubViews: [UIView] {
        return [accountTextField, passwordTextField, createWalletButton]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ETHColors.primaryBackgroundColor
        setupSubviews()
        makeConstraints()
        makeBinds()
    }
    
    private func setupSubviews() {
        view.addSubview(contentView)
        contentSubViews.forEach {[weak self] in
            self?.contentView.addArrangedSubview($0)
        }
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(40)
            $0.right.equalTo(-40)
        }
        contentSubViews.forEach { view in
            view.snp.makeConstraints {
                $0.height.equalTo(44)
            }
        }
    }
    
    private func makeBinds() {
        
        createWalletButton.rx.controlEvent(.touchUpInside).debounce(.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: {[weak self] in
            guard let self = self else {return}
            self.viewModel.startGenerateWalletWorkFlow()
        }).disposed(by: disposeBag)
        
        accountTextField.rx.text.orEmpty.bind(to: viewModel.accountInput).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.passwordInput).disposed(by: disposeBag)
        viewModel.createWalletIsEnable.observe(on: MainScheduler.instance).subscribe(onNext: {[weak self] isValid in
            guard let self = self else {return}
            self.createWalletButton.isEnabled = isValid
            self.createWalletButton.backgroundColor = isValid ? UIColor.ETHColors.primaryColor:UIColor.ETHColors.disabledControlColor
        }).disposed(by: disposeBag)
        
        viewModel.nextEvent.observe(on: MainScheduler.instance).subscribe(onNext: { event in
            ETHProgressHud.dismissHud()
            switch event {
            case let .success(message: message):
                ETHProgressHud.showSuccessHud(with: message)
            case let .failed(message: message):
                ETHProgressHud.showErrorHud(with: message)
            case let .showLoading:
                ETHProgressHud.showActivityHud()
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
}
