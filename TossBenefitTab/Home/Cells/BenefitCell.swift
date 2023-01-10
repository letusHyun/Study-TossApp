//
//  OtherBenefitCell.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/05.
//

import UIKit
import SnapKit
import Then

class BenefitCell: BaseCollectionViewCell {
  let benefitImageView = UIImageView()
  
  let descriptionLabel = UILabel().then {
    $0.textColor = .systemGray
    $0.font = .systemFont(ofSize: 18)
  }
  
  let titleLabel = UILabel().then {
    $0.textColor = .tintColor
    $0.font = .systemFont(ofSize: 18, weight: .bold)
  }
  
  func configure(item: Benefit) {
    benefitImageView.image = UIImage(named: item.imageName)
    descriptionLabel.text = item.description
    titleLabel.text = item.title
  }
  
  override func setupLayouts() {
    contentView.addSubview(benefitImageView)
    contentView.addSubview(descriptionLabel)
    contentView.addSubview(titleLabel)
  }
  
  override func setupConstraints() {
    benefitImageView.snp.makeConstraints {
      $0.centerY.equalTo(self.contentView.snp.centerY)
      $0.top.bottom.equalTo(self.contentView).inset(20)
      $0.size.equalTo(CGSize(width: 80, height: 80))
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.leading.equalTo(benefitImageView.snp.trailing).offset(10)
      $0.centerY.equalTo(benefitImageView.snp.centerY).offset(-14)
    }
    
    titleLabel.snp.makeConstraints {
      $0.leading.equalTo(benefitImageView.snp.trailing).offset(10)
      $0.centerY.equalTo(benefitImageView.snp.centerY).offset(14)
    }
  }
  
  override func setupStyles() {
  }
}
