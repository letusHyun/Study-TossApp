//
//  TodayBenefitCell.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/05.
//

import UIKit
import Then
import SnapKit

class TodayBenefitCell: BaseCollectionViewCell {
  //MARK: - Properties
  let thumbnailImageView = UIImageView().then {
    let image = UIImage(systemName: "sparkles")
//    image?.withTintColor(.systemYellow)
    $0.image = image
    $0.tintColor = .systemYellow
  }
  
  let titleLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 20, weight: .bold)
  }
  
  let button: UIButton = {
    var config = UIButton.Configuration.filled()
    config.contentInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 20)

    let btn = UIButton(configuration: config)
    btn.layer.cornerRadius = 5
    btn.layer.masksToBounds = true
    btn.isUserInteractionEnabled = false
    btn.titleLabel?.font = .boldSystemFont(ofSize: 30)

    return btn
  }()
  
  func configure(item: Benefit) {
    self.backgroundColor = .systemGray.withAlphaComponent(0.2)
    titleLabel.text = item.title
    button.setTitle(item.ctaTitle, for: .normal)
  }
  
  //MARK: - setup
  override func setupLayouts() {
    contentView.addSubview(thumbnailImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(button)
  }
  
  override func setupConstraints() {
    thumbnailImageView.snp.makeConstraints {
      $0.width.equalTo(50)
      $0.height.equalTo(70)
      $0.top.equalToSuperview().offset(30)
      $0.centerX.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(thumbnailImageView.snp.bottom).offset(10)
      $0.centerX.equalToSuperview()
    }
    
    button.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(10)
      $0.centerX.equalToSuperview()
      $0.bottom.equalToSuperview().inset(10)
    }
  }
  
  override func setupStyles() {
    self.layer.cornerRadius = 10
    self.layer.masksToBounds = true
  }
}
