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
  var dueDate: Date
  var itemID: Int
  
  init(lable: String, shouldRemind: Bool, dueDate: Date) {
    self.lable = lable
    self.checked = false
    self.shouldRemind = shouldRemind
    self.dueDate = dueDate
    self.itemID = DataModel.nextChecklistItemID()
  }
  
  func updateLable(_ lable: String) {
    self.lable = lable
  }
  
  func updateShouldRemind(_ shouldRemind: Bool) {
    self.shouldRemind = shouldRemind
  }
  
  func updateDate(_ date: Date) {
    self.dueDate = date
  }
  
  func scheduleNotification() {
    if shouldRemind && (dueDate > Date()) {
    }
  }
}
