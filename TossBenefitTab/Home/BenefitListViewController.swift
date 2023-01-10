//
//  ViewController.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/05.
//

import UIKit
import SnapKit

class BenefitListViewController: BaseViewController {
  
  /*
   1. 포인트
   2. 오늘의 혜택
   3. 나머지 혜택
   
   포인트 셀 눌렀을 때, 포인트 상세뷰로 넘어간다.
   혜택 관련 셀을 눌렀을 때, 혜택 상세뷰로 넘어간다.
   */
  
  //Hashable을 준수하는 여러가지 형태의 모델을 따를 수 있음(Benefit, MyPoint)
  typealias Item = AnyHashable
  
  enum Section: Int, CaseIterable {
    case today
    case other
  }
  
  //MARK: - Properties
  
  //ItemIdentifierType은 Hashable을 준수하는 타입이어야 하는데, 이를 준수하는 여러개의 객체 타입이 들어가므로 AnyHashable을 사용
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  //  var todaySectionItems: [AnyHashable] = [TodaySectionItem.mock]
//  var todaySectionItems: [AnyHashable] = TodaySectionItem(point: .default, today: .today).sectionItems
  var todaySectionItems: [AnyHashable] = [MyPoint.default, Benefit.today]
  var otherSectionItems: [AnyHashable] = Benefit.others
  
  
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
    //Presentation
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(
      collectionView: collectionView,
      cellProvider: { [weak self] collectionView, indexPath, item in
        let cell = self?.configureCell(collectionView, indexPath: indexPath, item: item)
        
        return cell
      })
    
    //data
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections(Section.allCases) //배열 순서에 따라 section 순서 결정됨
    snapshot.appendItems(todaySectionItems, toSection: .today) //배열 순서에 따라 item 순서 결정됨
    snapshot.appendItems(otherSectionItems, toSection: .other) //배열 순서에 따라 item 순서 결정됨
    dataSource.apply(snapshot)
  }
  
  //MARK: - Configure
  
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
  
  //MARK: - setup
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
    print("---->\(item)")
  }
}

