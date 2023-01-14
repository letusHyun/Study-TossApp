//
//  ViewController.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/05.
//

import UIKit
import SnapKit
import Combine

class BenefitListViewController: BaseViewController {

  typealias Item = AnyHashable
  
  enum Section: Int, CaseIterable {
    case today
    case other
  }
  
  //MARK: - Properties
  let viewModel: BenefitListViewModel = BenefitListViewModel()
  var subscriptions = Set<AnyCancellable>()
  
  //ItemIdentifierType은 Hashable을 준수하는 타입이어야 하는데, 이를 준수하는 여러개의 객체 타입이 들어가므로 AnyHashable을 사용
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  lazy var collectionView: UICollectionView = {
    let cv = UICollectionView(
      frame: .zero,
      collectionViewLayout: configureCollectionViewLayout()
    )
    cv.delegate = self
    cv.backgroundColor = .clear
    cv.showsHorizontalScrollIndicator = false
    cv.alwaysBounceVertical = true
    
    cv.register(MyPointCell.self, forCellWithReuseIdentifier: "MyPointCell")
    cv.register(TodayBenefitCell.self, forCellWithReuseIdentifier: "TodayBenefitCell")
    cv.register(BenefitCell.self, forCellWithReuseIdentifier: "BenefitCell")
    return cv
  }()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureCollectionView()
    viewModel.fetchIetms() //network ex
  }
  
  //MARK: - Configure
  private func configureCollectionView() {
    //Presentation
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(
      collectionView: collectionView,
      cellProvider: { [weak self] collectionView, indexPath, item in
        let cell = self?.configureCell(collectionView, indexPath: indexPath, item: item)
        return cell
      })
    
    //Data
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections(Section.allCases) //배열 순서에 따라 section 순서 결정됨
    snapshot.appendItems([], toSection: .today) //배열 순서에 따라 item 순서 결정됨
    snapshot.appendItems([], toSection: .other) //배열 순서에 따라 item 순서 결정됨
    dataSource.apply(snapshot)
  }
  
  //Layout
  private func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    let spacing: CGFloat = 10
    
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(60))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(60))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = spacing
    section.contentInsets = .init(top: 5, leading: 15, bottom: 5, trailing: 15)
    
    return UICollectionViewCompositionalLayout(section: section)
  }
  
  private func configureCell(_ collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? {
    guard let section = Section(rawValue: indexPath.section) else { return nil }
    
    switch section {
    case .today:
      if let point = item as? MyPoint {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPointCell", for: indexPath) as! MyPointCell
        cell.configure(item: point)
        return cell
      } else if let benefit = item as? Benefit {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayBenefitCell", for: indexPath) as! TodayBenefitCell
        cell.configure(item: benefit)
        return cell
      } else { return UICollectionViewCell() }
      
    case .other:
      if let benefit = item as? Benefit {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitCell", for: indexPath) as! BenefitCell
        cell.configure(item: benefit)
        return cell
      } else { return UICollectionViewCell() }
    }
  }
  
  override func bind() {
    //Output: data 들어오면 view에 rendering
    viewModel.$todaySectionItems
      .receive(on: RunLoop.main)
      .sink { [weak self] items in
        self?.applySnapshot(items: items, section: .today)
      }
      .store(in: &subscriptions)
    
    viewModel.$otherSectionItems
      .receive(on: RunLoop.main)
      .sink { [weak self] items in
        self?.applySnapshot(items: items, section: .other)
      }
      .store(in: &subscriptions)
    
    //Input: user interaction
    viewModel.benefitDidTapped
      .receive(on: RunLoop.main)
      .sink { [weak self] benefit in
        let buttonVC = ButtonBenefitViewController()
        buttonVC.viewModel = ButtonBenefitViewModel(benefit: benefit)
        self?.navigationController?.pushViewController(buttonVC, animated: true)
      }.store(in: &subscriptions)
    
    viewModel.pointDidTapped
      .receive(on: RunLoop.main)
      .sink { [weak self] point in
        let myPointVC = MyPointViewController()
        myPointVC.viewModel = MyPointViewModel(point: point)
        self?.navigationController?.pushViewController(myPointVC, animated: true)
      }.store(in: &subscriptions)
  }
  
  private func applySnapshot(items: [Item], section: Section) {
    var snapshot = dataSource.snapshot()
    snapshot.appendItems(items, toSection: section)
    dataSource.apply(snapshot)
  }
  //MARK: - Setup
  override func setupLayouts() {
    view.addSubview(collectionView)
  }
  
  override func setupConstraints() {
    self.collectionView.snp.makeConstraints {
      $0.edges.equalTo(self.view.safeAreaLayoutGuide)
    }
  }
  
  override func setupStyles() {
    self.navigationItem.title = "혜택"
  }
}

extension BenefitListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = dataSource.itemIdentifier(for: indexPath)
    
    if let benefit = item as? Benefit {
      viewModel.benefitDidTapped.send(benefit)
    } else if let point = item as? MyPoint {
      viewModel.pointDidTapped.send(point)
    } else { }
  }
}
