//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by anikin02 on 28.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  let dataModel = DataModel()
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    let navigationController = window!.rootViewController as! UINavigationController
    let controller = navigationController.viewControllers[0] as! AllListsViewController
    controller.dataModel = dataModel
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    saveData()
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    saveData()
  }
  
  // MARK: - Helper Methods
  func saveData() {
    dataModel.saveChecklists()
  }
}

