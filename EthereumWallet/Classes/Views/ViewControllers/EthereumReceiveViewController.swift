//
//  EthereumReceiveViewController.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/31.
//

import Foundation
import RxSwift
import RxCocoa

class EthereumReceiveViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private var viewModel = EthereumReceiveViewModel()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = EthereumString.Home.receive.localizedString
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.spacing = 20
        contentStackView.axis = .vertical
        return contentStackView
    }()
    
    private lazy var qrCodeImageView: UIImageView = {
        let qrcodeImageView = UIImageView()
        qrcodeImageView.contentMode = .scaleAspectFit
        return qrcodeImageView
    }()
    
    private lazy var qrCodeDescLabel: UILabel = {
       let qrCodeDescLabel = UILabel()
        qrCodeDescLabel.font = .Label.littleTitleFont
        qrCodeDescLabel.text = EthereumString.Receive.qrCodeLabelDesc.localizedString
        qrCodeDescLabel.textAlignment = .center
        return qrCodeDescLabel
    }()
    
    private lazy var walletAddressShareView: EthereumCopyAndShareView = {
        let walletAddressShareView = EthereumCopyAndShareView()
        return walletAddressShareView
    }()
    
    var subViews: [UIView] {
        return [titleLabel, qrCodeImageView, qrCodeDescLabel]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        makeConstraints()
        makeBinds()
    }
    
    private func setupSubViews() {
        view.backgroundColor = .ETHColors.primaryBackgroundColor
        view.addSubview(contentStackView)
        subViews.forEach {
            contentStackView.addArrangedSubview($0)
        }
        view.addSubview(walletAddressShareView)
    }
    
    private func makeConstraints() {
        contentStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalTo(50)
            $0.right.equalTo(-50)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        qrCodeImageView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(qrCodeImageView.snp.width)
        }
        
        qrCodeDescLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        walletAddressShareView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentStackView.snp.bottom).offset(20)
        }
    }
    
    private func makeBinds() {
        viewModel.walletAccount.observe(on: MainScheduler.instance).subscribe(onNext: {[weak self] wallet in
            guard let self = self, let wallet = wallet else {return}
            self.qrCodeImageView.image = wallet.qrImage
            self.walletAddressShareView.renderWallet(by: wallet.addressValue)
        }).disposed(by: disposeBag)
    }
}

extension EthereumReceiveViewController: EthereumRouterController {
    func setContext(_ context: Any?) {
        viewModel.context = context
    }
}
