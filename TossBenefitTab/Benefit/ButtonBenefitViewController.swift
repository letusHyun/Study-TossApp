//
//  ButtonViewController.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/12.
//

import UIKit
import SnapKit
import Combine

class ButtonBenefitViewController: BaseViewController {
  // MARK: - Properties
  var viewModel: ButtonBenefitViewModel!
  var subscriptions = Set<AnyCancellable>()
  
  let subTitleLabel: UILabel = {
    let st = UILabel()
    st.text = "버튼을 누르면 다른앱이 열려요"
    st.font = .systemFont(ofSize: 16, weight: .bold)
    st.textColor = .systemGray
    return st
  }()
  let titleLabel: UILabel = {
    let title = UILabel()
    title.text = """
    버튼을 누르기만 해도
    포인트를 드려요
    """
    title.numberOfLines = 0
    title.font = .systemFont(ofSize: 24, weight: .bold)
    title.textColor = .label
    return title
  }()
  let iconImageView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "ic_button_benefit")
    view.contentMode = .scaleAspectFit
    return view
  }()
  let button: UIButton = {
    let btn = UIButton()
    btn.setTitleColor(.white, for: .normal)
    btn.backgroundColor = .tintColor
    btn.layer.cornerRadius = 10
    btn.isUserInteractionEnabled = false
    return btn
  }()
  let stackView: UIStackView = {
    let sv = UIStackView()
    sv.axis = .vertical
    sv.spacing = 0
    sv.distribution = .fillEqually
    return sv
  }()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchDetails()
  }
  
  // MARK: - Setup
  override func setupLayouts() {
    view.addSubview(subTitleLabel)
    view.addSubview(titleLabel)
    view.addSubview(iconImageView)
    view.addSubview(stackView)
    view.addSubview(button)
  }
  
  override func setupConstraints() {
    subTitleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(30)
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(subTitleLabel.snp.bottom).offset(20)
      $0.leading.equalTo(subTitleLabel.snp.leading)
    }
    
    iconImageView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.height.equalTo(300)
      $0.width.equalTo(200)
    }
    
    stackView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(iconImageView.snp.bottom).offset(20)
      $0.bottom.lessThanOrEqualTo(button.snp.top).offset(-10)
    }
    
    button.snp.makeConstraints {
      $0.height.equalTo(60)
      $0.centerX.equalToSuperview()
      $0.leading.equalToSuperview().offset(30)
      $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
    }
  }
  
  override func setupStyles() {
    navigationController?.navigationItem.largeTitleDisplayMode = .never
  }
  
  override func bind() {
    //Output
    viewModel.$benefit
      .receive(on: RunLoop.main)
      .sink { [weak self] benefit in
        self?.button.setTitle(benefit.ctaTitle, for: .normal)
      }.store(in: &subscriptions)
    
    viewModel.$benefitDetails
      .compactMap { $0 }
      .receive(on: RunLoop.main)
      .sink { [weak self] details in
        self?.addGuides(details: details)
      }.store(in: &subscriptions)
  }
  // MARK: - Private
  private func addGuides(details: BenefitDetails) {
    let guideView = stackView.arrangedSubviews.filter { $0 is BenefitGuideView }
    guard guideView.isEmpty else { return }
    
    let guideViews: [BenefitGuideView] = details.guides.map {
      let guideView = BenefitGuideView(frame: .zero)
      guideView.iconImageView.image = UIImage(systemName: $0.iconName)
      guideView.titleLabel.text = $0.guide
      return guideView
    }
    
    guideViews.forEach {
      self.stackView.addArrangedSubview($0)
      $0.snp.makeConstraints {
        $0.height.equalTo(40)
      }
    }
  }
}

