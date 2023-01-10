//
//  MyPointViewController.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/10.
//

import UIKit
import Then
import SnapKit

class MyPointViewController: BaseViewController {
  // MARK: - Properties
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
    $0.textColor = .black
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
  
  var point: MyPoint = .default
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Setup
  override func setupLayouts() {

    view.addSubview(stackView)
    
    let _ = [descriptionLabel, pointLabel, btnSV].map {
      stackView.addArrangedSubview($0)
    }
    let _ = [withdrawButton, useButton].map {
      btnSV.addArrangedSubview($0)
    }
  }
  
  override func setupConstraints() {
    stackView.snp.makeConstraints {
      $0.left.right.equalToSuperview().inset(10)
      $0.top.equalToSuperview().inset(40)
    }
    
    btnSV.snp.makeConstraints {
      $0.height.equalTo(50)
    }
    
  }
  override func setupStyles() {
    
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct MyPointViewControllerPreView:
  PreviewProvider {
  static var previews: some View {
    MyPointViewController().toPreview()
  }
}
#endif




