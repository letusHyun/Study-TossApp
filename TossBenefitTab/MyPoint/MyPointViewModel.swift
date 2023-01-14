//
//  MyPointViewModel.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/13.
//

import Foundation
import Combine

final class MyPointViewModel {
  @Published var point: MyPoint
  
  init(point: MyPoint) {
    self.point = point
  }
}
