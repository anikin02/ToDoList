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
  var shouldRemind: Bool
  var dueDate:Date
  var itemID: Int
  
  init(lable: String) {
    self.lable = lable
    self.checked = false
    self.shouldRemind = false
    self.dueDate = Date()
    self.itemID = DataModel.nextChecklistItemID()
  }
  
  func updateLable(_ lable: String) {
    self.lable = lable
  }
}
