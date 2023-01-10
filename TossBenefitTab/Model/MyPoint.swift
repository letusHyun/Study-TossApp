//
//  MyPoint.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/05.
//

import Foundation

struct MyPoint: Hashable {
  var point: Int
}

extension MyPoint {
  static let `default` = MyPoint(point: 0)
}
