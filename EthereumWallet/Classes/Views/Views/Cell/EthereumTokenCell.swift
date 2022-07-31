//
//  EtherenumTokenCell.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/31.
//

import Foundation

class EthereumTokenCell: UICollectionViewCell {
    
    private lazy var tokenNumberLabel: UILabel = {
        let tokenNumberLabel = UILabel()
        tokenNumberLabel.font = .Label.titleFont
        return tokenNumberLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        makeConstraints()
    }
    
    private func setupSubViews() {
        contentView.addSubview(tokenNumberLabel)
    }
    
    private func makeConstraints() {
        tokenNumberLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(44)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderUI(by model: EthereumTokenModel) {
        tokenNumberLabel.text = model.tokenNumbers
    }
}
