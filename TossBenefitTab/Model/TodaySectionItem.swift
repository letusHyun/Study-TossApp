//
//  TodaySectionItem.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/05.
//

import Foundation

struct TodaySectionItem: Hashable {
  var point: MyPoint
  let today: Benefit
  
  var sectionItems: [AnyHashable] {
    return [point, today]
  }
}

extension TodaySectionItem {
  static let mock = TodaySectionItem(
    point: MyPoint(point: 0),
    today: Benefit.walk
  )
}
