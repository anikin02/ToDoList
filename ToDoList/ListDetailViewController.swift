//
//  ListDetailViewController.swift
//  ToDoList
//
//  Created by anikin02 on 08.09.2023.
//

import UIKit

protocol ListDetailViewControllerDelegate: AnyObject {
  func listDetailViewControllerDelegateDidCancel(_ contoller: ListDetailViewController)
  func listDetailViewController(_ contoller: ListDetailViewController, didFinishAdding list: Checklist)
  func listDetailViewController(_ contoller: ListDetailViewController, didFinishEditing list: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate {

  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var saveBarButton: UIBarButtonItem!
  
  weak var delegate: ListDetailViewControllerDelegate?
  
  var listToEdit: Checklist?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let list = listToEdit {
      title = "Edit Checklist"
      textField.text = list.name
      
      saveBarButton.isEnabled = true
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
    delegate?.listDetailViewControllerDelegateDidCancel(self)
  }
  
  @IBAction func save() {
    if let list = listToEdit {
      list.updateName(textField.text!)
      delegate?.listDetailViewController(self, didFinishEditing: list)
    } else {
      let list = Checklist(name: textField.text!)
      delegate?.listDetailViewController(self, didFinishAdding: list)
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
