//
//  EthereumButton.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/31.
//

import Foundation

class EthereumButton: UIControl {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var model: ETHActionModel? {
        didSet {
            guard let model = model else {
                return
            }
            setImage(to: model.image)
            setTitle(to: model.title)
        }
    }
    
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .ETHColors.primaryColor
        titleLabel.font = .Label.smallTitleFont
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeSubViews()
        makeConstraints()
    }
    
    public func setImage(to image: UIImage) {
        self.imageView.image = image
    }
    
    public func setTitle(to title: String) {
        self.titleLabel.text = title
    }
    
    private func makeSubViews() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.width.equalTo(36)
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.left.greaterThanOrEqualTo(0)
            $0.right.lessThanOrEqualTo(0)
        }
        titleLabel.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
