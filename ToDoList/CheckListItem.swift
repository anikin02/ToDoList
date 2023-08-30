//
//  CheckListItem.swift
//  ToDoList
//
//  Created by anikin02 on 30.08.2023.
//

import Foundation

class CheckListItem {
  var Lable: String
  var Checked: Bool
  
  init(Lable: String) {
    self.Lable = Lable
    self.Checked = false
  }
}
