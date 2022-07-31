//
//  EtherenumHomeViewController.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation
import RxSwift
import RxCocoa

class EtherenumHomeViewController: UIViewController {
    
    private lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(handleRefreshControl), for: UIControl.Event.valueChanged)
        return view
    }()
    
    let disposeBag = DisposeBag()
    
    var viewModel: ETHWalletCollectionViewModelProtocol
    
    lazy var dataSource = makeDataSource()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.setContentCompressionResistancePriority(.required, for: .vertical)
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .automatic
        return collectionView
    }()
        
    // MARK: - Lifecycle
    init(viewModel: ETHWalletCollectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .ETHColors.primaryBackgroundColor
        title = EthereumString.Home.title.localizedString
        collectionView.refreshControl = refreshControl
        refreshControl.beginRefreshing()
        viewModel.viewDidLoad()
        setupSubViews()
        makeConstraints()
        makeBinds()
    }
    
    private func setupSubViews() {
        view.addSubview(collectionView)
        collectionView.register(EthereumTokenCell.self, forCellWithReuseIdentifier: EthereumTokenCell.reuseIdentifier)
        collectionView.register(EthereumAccountCell.self, forCellWithReuseIdentifier: EthereumAccountCell.reuseIdentifier)
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func makeBinds() {
        viewModel.albumCollectionSnapshot.observe(on: MainScheduler.instance).subscribe(onNext: {[weak self] snap in
            guard let self = self else {return}
            self.dataSource.apply(snap)
        }).disposed(by: disposeBag)
        
        viewModel.nextUIEvent.observe(on: MainScheduler.instance).subscribe(onNext: {[weak self] event in
            switch event {
            case .endRefresh:
                self?.refreshControl.endRefreshing()
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
}

extension EtherenumHomeViewController {
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        let sectionProvider = { [weak self] (sectionIndex: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            let sectionIdentifiers = self.dataSource.snapshot().sectionIdentifiers
            if sectionIndex >= sectionIdentifiers.count { return nil }
            let sectionKind = sectionIdentifiers[sectionIndex]
            switch sectionKind.sectionType {
            case .account:
                return self.generateAccountLayout()
            case .tokens:
                return self.generateTokensLayout()
            }
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    func generateAccountLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupHeight = NSCollectionLayoutDimension.estimated(200)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func generateTokensLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(50)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupHeight = NSCollectionLayoutDimension.estimated(50)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: groupHeight
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<EthereumCollectionSection, EthereumCollectionItem> {
        let dataSource: UICollectionViewDiffableDataSource<EthereumCollectionSection, EthereumCollectionItem> = .init(
            collectionView: collectionView) { collectionView, indexPath, item in
                let sectionIdentifiers = self.dataSource.snapshot().sectionIdentifiers
                if indexPath.section >= sectionIdentifiers.count { return nil }
                let sectionKind = sectionIdentifiers[indexPath.section]
                
                switch item.itemType {
                case let .account(model):
                    let cell: EthereumAccountCell = collectionView.dequeue(indexPath: indexPath)
                    cell.renderUI(by: model)
                    return cell
                case let .token(model):
                    let cell: EthereumTokenCell = collectionView.dequeue(indexPath: indexPath)
                    cell.renderUI(by: model)
                    return cell
                }
            }
        return dataSource
    }
    
}

extension EtherenumHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension EtherenumHomeViewController: EthereumRouterController {
    func setContext(_ context: Any?) {
        viewModel.context = context
    }
}

extension EtherenumHomeViewController {
    @objc func handleRefreshControl() {
        viewModel.viewDidLoad()
    }
}
