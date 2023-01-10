//
//  BaseCollectionViewCell.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/05.
//

import UIKit.UICollectionViewCell

class BaseCollectionViewCell: UICollectionViewCell {
 
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayouts()
    setupConstraints()
    setupStyles()
    bind()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupLayouts() { }
  func setupStyles() { }
  func setupConstraints() { }
  func bind() { }
}
