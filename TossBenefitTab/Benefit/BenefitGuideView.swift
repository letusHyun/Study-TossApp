//
//  BenefitGuideView.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/13.
//

import UIKit
import SnapKit

final class BenefitGuideView: UIView {
  // MARK: - Properties
  lazy var iconImageView: UIImageView = {
    UIImageView()
  }()
  
  lazy var titleLabel: UILabel = {
    UILabel()
  }()
  
  // MARK: - LifeCycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayouts()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - setup
  private func setupLayouts() {
    addSubview(iconImageView)
    addSubview(titleLabel)
  }
  
  private func setupConstraints() {
    
    iconImageView.snp.makeConstraints {
      $0.centerY.equalTo(self.snp.centerY)
      $0.leading.equalTo(self.snp.leading).offset(30)
      $0.size.equalTo(30)
    }
    
    titleLabel.snp.makeConstraints {
      $0.left.equalTo(iconImageView.snp.right).offset(20)
      $0.centerY.equalTo(iconImageView.snp.centerY)
    }
  }
}
