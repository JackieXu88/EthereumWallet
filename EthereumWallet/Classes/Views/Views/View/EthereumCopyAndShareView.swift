//
//  EthereumCopyAndShareView.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/31.
//

import Foundation
import RxSwift
import RxCocoa

class EthereumCopyAndShareView: UIView {
    
    let disposeBag = DisposeBag()
    
    private lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.spacing = 8
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        return contentStackView
    }()
    
    private lazy var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.font = .Label.miniTitleFont
        addressLabel.lineBreakMode = .byTruncatingMiddle
        return addressLabel
    }()
    
    private lazy var copyButton: UIButton = {
        let copyButton = UIButton(type: .custom)
        copyButton.layer.cornerRadius = 13
        copyButton.layer.borderColor = UIColor.ETHColors.primaryColor.cgColor
        copyButton.layer.borderWidth = 1.0
        copyButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        copyButton.setTitle("  \(EthereumString.Receive.copyTitle.localizedString)  ", for: .normal)
        copyButton.setTitleColor(UIColor.ETHColors.primaryColor, for: .normal)
        copyButton.titleLabel?.font = .Label.littleTitleFont
        return copyButton
    }()
    
    private lazy var shareButton: UIButton = {
        let shareButton = UIButton(type: .custom)
        shareButton.setImage(EthereumImages.Home.share.image, for: .normal)
        return shareButton
    }()
    
    var contentSubViews: [UIView] {
        return [addressLabel, copyButton, shareButton]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        makeConstraints()
        makeBinds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        self.backgroundColor = UIColor.ETHColors.tinyPrimaryBackgroundColor
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        addSubview(contentStackView)
        contentSubViews.forEach {
            self.contentStackView.addArrangedSubview($0)
        }
    }
    
    private func makeConstraints() {
        contentStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(8)
            $0.right.equalTo(-8)
            $0.height.equalTo(40)
        }
        addressLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
        copyButton.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.top.equalTo(8)
            $0.bottom.equalTo(-8)
        }
        
        shareButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
    
    func renderWallet(by address: String) {
        self.addressLabel.text = address
    }
    
    func makeBinds() {
        copyButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] in
            guard let self = self else {return}
            UIPasteboard.general.string = self.addressLabel.text
            ETHProgressHud.showSuccessHud(with: EthereumString.Receive.copySuccess.localizedString)
        }).disposed(by: disposeBag)
        
        shareButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] in
            guard let text = self?.addressLabel.text else {return}
            ETHShareKits.share(message: text)
        }).disposed(by: disposeBag)
    }
}
