//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by anikin02 on 28.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    saveData()
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    saveData()
  }
  
  // MARK: - Helper Methods
  func saveData() {
    let navigationController = window!.rootViewController as! UINavigationController
    let controller = navigationController.viewControllers[0] as! AllListsViewController
    controller.saveChecklists()
  }
}

