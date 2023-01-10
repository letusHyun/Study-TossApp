//
//  MyPointViewController.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/10.
//

import UIKit

class MyPointViewController: UIViewController {
  
  var point: MyPoint = .default
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
