//
//  SceneDelegate.swift
//  TossBenefitTab
//
//  Created by SeokHyun on 2023/01/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    
    let VC = BenefitListViewController()
    VC.view.backgroundColor = .systemBackground
    
    let navigationController = UINavigationController(rootViewController: VC)
    navigationController.navigationBar.prefersLargeTitles = true
    
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
}

