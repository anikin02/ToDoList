//
//  CheckListItem.swift
//  ToDoList
//
//  Created by anikin02 on 30.08.2023.
//

import Foundation

class CheckListItem: NSObject, Codable {
  var lable: String
  var checked: Bool
  
  init(lable: String) {
    self.lable = lable
    self.checked = false
  }
  
  func updateLable(_ lable: String) {
    self.lable = lable
  }
}
