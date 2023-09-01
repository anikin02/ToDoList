//
//  CheckListViewController.swift
//  ToDoList
//
//  Created by anikin02 on 28.08.2023.
//

import UIKit

class CheckListViewController: UITableViewController, ItemDetailViewControllerDelegate {
  var items: [CheckListItem] = [CheckListItem]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  // MARK: - Table View Data Source
  
  func configureCheckmark(for cell: UITableViewCell, with item: CheckListItem) {
    let label = cell.viewWithTag(1001) as! UILabel
    
    if item.Checked {
      label.text = "✓"
    } else {
      label.text = ""
    }
  }
  func configureLable(for cell: UITableViewCell, with item: CheckListItem) {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.Lable
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
    let item = items[indexPath.row]
    
    configureLable(for: cell, with: item)
    configureCheckmark(for: cell, with: item)

    return cell
  }
  
  // MARK: - Table View Delegates
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if let cell = tableView.cellForRow(at: indexPath) {
      let item = items[indexPath.row]
      item.Checked.toggle()
      configureCheckmark(for: cell, with: item)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    items.remove(at: indexPath.row)
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  
  // MARK: - Add Item ViewController Delegates
  
  func itemDetailViewControllerDelegateDidCancel(_ contoller: ItemDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func itemDetailViewController(_ contoller: ItemDetailViewController, didFinishAdding item: CheckListItem) {
    let newRowIndex = items.count
    items.append(item)
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    
    navigationController?.popViewController(animated: true)
  }
  
  func itemDetailViewController(_ contoller: ItemDetailViewController, didFinishEditing item: CheckListItem) {
    if let index = items.firstIndex(of: item) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        configureLable(for: cell, with: item)
      }
    }
    
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddItem" {
      let controller = segue.destination as! ItemDetailViewController
      controller.delegate = self
    } else if segue.identifier == "EditItem" {
      let controller = segue.destination as! ItemDetailViewController
      controller.delegate = self
      
      if let indexPath = tableView.indexPath(
        for: sender as! UITableViewCell) {
        controller.itemToEdit = items[indexPath.row]
      }
    }
  }
}
