//
//  CheckListItem.swift
//  ToDoList
//
//  Created by anikin02 on 30.08.2023.
//

import Foundation

class CheckListItem: NSObject {
  var Lable: String
  var Checked: Bool
  
  init(lable: String) {
    self.Lable = lable
    self.Checked = false
  }
  
  func updateLable(_ lable: String) {
    Lable = lable
  }
}
