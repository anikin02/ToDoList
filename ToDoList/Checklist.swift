//
//  Checklist.swift
//  ToDoList
//
//  Created by anikin02 on 07.09.2023.
//

import Foundation

class Checklist: NSObject, Codable {
  var name: String
  var items: [CheckListItem]
  
  init(name: String) {
    self.name = name
    self.items = [CheckListItem]()
  }
  
  func updateName(_ name: String) {
    self.name = name
  }
}
