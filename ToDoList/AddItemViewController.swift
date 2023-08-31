//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by anikin02 on 30.08.2023.
//

import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
  func addItemViewControllerDidCancel(_ contoller: AddItemViewController)
  func addItemViewController(_ contoller: AddItemViewController, didFinishAdding item: CheckListItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {

  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var saveBarButton: UIBarButtonItem!
  
  weak var delegate: AddItemViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
    delegate?.addItemViewControllerDidCancel(self)
  }
  
  @IBAction func save() {
    let item = CheckListItem(Lable: textField.text!)
    delegate?.addItemViewController(self, didFinishAdding: item)
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
