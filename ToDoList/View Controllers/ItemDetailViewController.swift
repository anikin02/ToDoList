//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by anikin02 on 30.08.2023.
//

import UIKit

protocol ItemDetailViewControllerDelegate: AnyObject {
  func itemDetailViewControllerDelegateDidCancel(_ contoller: ItemDetailViewController)
  func itemDetailViewController(_ contoller: ItemDetailViewController, didFinishAdding item: CheckListItem)
  func itemDetailViewController(_ contoller: ItemDetailViewController, didFinishEditing item: CheckListItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {

  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var saveBarButton: UIBarButtonItem!
  @IBOutlet weak var shouldRemindSwitch: UISwitch!
  @IBOutlet weak var datePicker: UIDatePicker!
  
  weak var delegate: ItemDetailViewControllerDelegate?
  
  var itemToEdit: CheckListItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let item = itemToEdit {
      title = "Edit Item"
      textField.text = item.lable
      
      saveBarButton.isEnabled = true
      
      shouldRemindSwitch.isOn = item.shouldRemind
      datePicker.date = item.dueDate
    } else {
      let nextDay = Date().addingTimeInterval(86400)
      datePicker.setDate(nextDay, animated: true)
    }
    
    navigationItem.largeTitleDisplayMode = .never
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  // MARK: - Table view Delegates
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return nil
  }
  
  // MARK: - Actions
  
  @IBAction func cancel() {
    delegate?.itemDetailViewControllerDelegateDidCancel(self)
  }
  
  @IBAction func save() {
    if let item = itemToEdit {
      item.updateLable(textField.text!)
      item.updateShouldRemind(shouldRemindSwitch.isOn)
      item.updateDate(datePicker.date)
      delegate?.itemDetailViewController(self, didFinishEditing: item)
    } else {
      let item = CheckListItem(lable: textField.text!,
                               shouldRemind: shouldRemindSwitch.isOn,
                               dueDate: datePicker.date)
      delegate?.itemDetailViewController(self, didFinishAdding: item)
    }
  }
  
  // MARK: - Text Field Delegates
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let oldText = textField.text!
    let stringRange = Range(range, in: oldText)!
    let newText = oldText.replacingCharacters(in: stringRange, with: string)
    if newText.isEmpty {
      saveBarButton.isEnabled = false
    } else {
      saveBarButton.isEnabled = true
    }
    return true
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    saveBarButton.isEnabled = false
    return true
  }
}
