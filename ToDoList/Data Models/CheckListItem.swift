//
//  CheckListItem.swift
//  ToDoList
//
//  Created by anikin02 on 30.08.2023.
//

import UserNotifications
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
    removeNotification()
    if shouldRemind && dueDate > Date() {
      let content = UNMutableNotificationContent()
      content.title = "Reminder:"
      content.body = lable
      content.sound = UNNotificationSound.default

      let calendar = Calendar(identifier: .gregorian)
      let components = calendar.dateComponents(
        [.year, .month, .day, .hour, .minute], from: dueDate)

      let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
  
      let request = UNNotificationRequest(
        identifier: "\(itemID)",
        content: content,
        trigger: trigger)

      let center = UNUserNotificationCenter.current()
      center.add(request)
    }
  }
  
  func removeNotification() {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"]) }
}
