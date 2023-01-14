//
//  MyPointViewController.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/10.
//

import UIKit
import Then
import SnapKit
import Combine

class MyPointViewController: BaseViewController {
  // MARK: - Properties
  var viewModel: MyPointViewModel!
  var subscriptions = Set<AnyCancellable>()
  
  let stackView = UIStackView().then {
    $0.axis = .vertical
    $0.distribution = .fill
    $0.spacing = 5
  }
  let descriptionLabel = UILabel().then {
    $0.textColor = .systemGray
    $0.font = .systemFont(ofSize: 15)
    $0.text = "내 포인트"
  }
  let pointLabel = UILabel().then {
    $0.textColor = .label
    $0.font = .systemFont(ofSize: 20, weight: .bold)
    $0.text = "0 원"
  }
  let withdrawButton = UIButton().then {
    $0.setTitle("출금하기", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    $0.backgroundColor = .tintColor
    $0.layer.masksToBounds = true
    $0.layer.cornerRadius = 5
  }
  let useButton = UIButton().then {
    $0.setTitle("사용하기", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    $0.backgroundColor = .tintColor
    $0.layer.masksToBounds = true
    $0.layer.cornerRadius = 5
  }
  lazy var btnSV = UIStackView().then {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.spacing = 15
  }
  let subDescriptionLabel = UILabel().then {
    $0.textColor = .label
    $0.text = """
    내역이 없어요
    포인트를 모아볼까요?
    """
    $0.textAlignment = .center
    $0.numberOfLines = 0
    $0.font = .systemFont(ofSize: 20, weight: .bold)
  }
  let gatherButton: UIButton = {
    var titleAttr = AttributedString("모으기")
    titleAttr.font = .systemFont(ofSize: 18, weight: .bold)
    
    var config = UIButton.Configuration.filled()
    config.attributedTitle = titleAttr
    config.baseBackgroundColor = .tintColor
    config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
    return UIButton(configuration: config)
  }()
  
  // MARK: - Setup
  override func setupLayouts() {
    view.addSubview(stackView)
    let _ = [descriptionLabel, pointLabel, btnSV].map {
      stackView.addArrangedSubview($0)
    }
    let _ = [withdrawButton, useButton].map {
      btnSV.addArrangedSubview($0)
    }
    
    view.addSubview(subDescriptionLabel)
    view.addSubview(gatherButton)
  }
  
  override func setupConstraints() {
    stackView.snp.makeConstraints {
      $0.left.right.equalToSuperview().inset(10)
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
    }
    
    btnSV.snp.makeConstraints {
      $0.height.equalTo(50)
    }
    
    subDescriptionLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview().offset(60)
      $0.centerX.equalToSuperview()
    }
    
    gatherButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.centerY.equalTo(subDescriptionLabel.snp.bottom).offset(40)
      $0.width.equalTo(70)
      $0.height.equalTo(40)
    }
  }
  
  override func setupStyles() {
    navigationItem.largeTitleDisplayMode = .never
  }
  
  override func bind() {
    viewModel.$point
      .receive(on: RunLoop.main)
      .sink { [weak self] point in
        self?.pointLabel.text = "\(point.point)원"
      }.store(in: &subscriptions)
  }
}
