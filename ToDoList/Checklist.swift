//
//  Checklist.swift
//  ToDoList
//
//  Created by anikin02 on 07.09.2023.
//

import Foundation


class Checklist: NSObject, Codable {
  var name: String
  
  init(name: String) {
    self.name = name
  }
  
  func updateName(_ name: String) {
    self.name = name
  }
}
