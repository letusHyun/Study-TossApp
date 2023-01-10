//
//  PointCell.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/05.
//

import UIKit
import SnapKit
import Then

class MyPointCell: BaseCollectionViewCell {
  let pointImageView = UIImageView()
  
  let descriptionLabel = UILabel().then {
    $0.textColor = .systemGray
    $0.font = .systemFont(ofSize: 18)
  }
  let pointLabel = UILabel().then {
    $0.textColor = .label
    $0.font = .systemFont(ofSize: 18, weight: .bold)
  }
  
  
  func configure(item: MyPoint) {
    pointImageView.image = UIImage(named: "ic_point")
    descriptionLabel.text = "내 포인트"
    pointLabel.text = "\(item.point)원"
  }
  
  override func setupLayouts() {
    contentView.addSubview(pointImageView)
    contentView.addSubview(descriptionLabel)
    contentView.addSubview(pointLabel)
  }
  
  override func setupConstraints() {
    pointImageView.snp.makeConstraints {
      $0.centerY.equalTo(self.contentView.snp.centerY)
      $0.top.bottom.equalTo(self.contentView).inset(20)
      $0.size.equalTo(CGSize(width: 80, height: 80))
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.leading.equalTo(pointImageView.snp.trailing).offset(10)
      $0.centerY.equalTo(pointImageView.snp.centerY).offset(-14)
    }
    
    pointLabel.snp.makeConstraints {
      $0.leading.equalTo(pointImageView.snp.trailing).offset(10)
      $0.centerY.equalTo(pointImageView.snp.centerY).offset(14)
    }
  }
  
  override func setupStyles() {
  }
}
