//
//  BaseViewController.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/05.
//

import UIKit.UIViewController

class BaseViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayouts()
    setupConstraints()
    setupStyles()
    bind()
  }
  
  func setupLayouts() { }
  func setupConstraints() { }
  func setupStyles() { }
  func bind() { }
}
