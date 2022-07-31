//
//  EthereumAccountCell.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/31.
//

import Foundation

class EthereumAccountCell: UICollectionViewCell {
    
    private lazy var actionStackView: UIStackView = {
        let actionStackView = UIStackView()
        actionStackView.axis = .horizontal
        actionStackView.spacing = 20
        return actionStackView
    }()
    
    private lazy var accountNameLabel: UILabel = {
        let accountNameLabel = UILabel()
        accountNameLabel.font = .Label.LargeTitleFont
        accountNameLabel.textAlignment = .center
        return accountNameLabel
    }()
    
    private lazy var walletAddressLabel: UILabel = {
        let walletAddressLabel = UILabel()
        walletAddressLabel.font = .Label.littleTitleFont
        walletAddressLabel.backgroundColor = .ETHColors.lightPrimaryBackgroundColor
        walletAddressLabel.layer.cornerRadius = 15
        walletAddressLabel.layer.masksToBounds = true
        walletAddressLabel.lineBreakMode = .byTruncatingMiddle
        return walletAddressLabel
    }()
    
    var contentSubViews: [UIView] {
        return [accountNameLabel, walletAddressLabel, actionStackView]
    }
    
    private lazy var contentParentView: UIView = {
        let contentParentView = UIView()
        return contentParentView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        makeConstraints()
        makeBinds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(contentParentView)
        contentSubViews.forEach {
            self.contentParentView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        contentParentView.snp.makeConstraints {
            $0.left.equalTo(40)
            $0.right.equalTo(-40)
            $0.top.bottom.equalToSuperview()
        }
        
        accountNameLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.left.right.equalTo(0)
            $0.height.equalTo(30)
        }
        
        walletAddressLabel.snp.makeConstraints {
            $0.height.equalTo(accountNameLabel)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.top.equalTo(accountNameLabel.snp.bottom).offset(10)
        }
        
        actionStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(walletAddressLabel.snp.bottom).offset(10)
            $0.bottom.equalTo(-10)
        }
    }
    
    private func makeBinds() {
        
    }
    func renderUI(by model: EthereumHomeAccountInfoModel) {
        self.accountNameLabel.text = model.nickName
        self.walletAddressLabel.text = "  \(model.wallet.addressValue)  "
        actionStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        model.actionModels.map { model -> EthereumButton in
            let button = EthereumButton()
            button.model = model
            button.addTarget(self, action: #selector(ethereumButtonTouched(sender:)), for: .touchUpInside)
            return button
        }.forEach {
            actionStackView.addArrangedSubview($0)
        }
    }
    
    @objc func ethereumButtonTouched(sender: EthereumButton) {
        if let model  = sender.model {
            EthereumRouter.default.push(model.router.urlPattern, context: model.context)
        }
    }
}
