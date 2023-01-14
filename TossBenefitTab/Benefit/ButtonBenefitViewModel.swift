//
//  ButtonBenefitViewModel.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/13.
//

import Foundation

final class ButtonBenefitViewModel {
  @Published var benefit: Benefit = .today
  @Published var benefitDetails: BenefitDetails?
  
  init(benefit: Benefit) {
    self.benefit = benefit
  }
  
  //network ex
  func fetchDetails() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      self.benefitDetails = .default
    }
  }
}
