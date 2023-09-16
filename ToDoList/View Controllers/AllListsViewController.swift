//
//  AllListsViewController.swift
//  ToDoList
//
//  Created by anikin02 on 07.09.2023.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
  let cellIdentifier = "ChecklistCell"
  var dataModel: DataModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  // MARK: - Table View Data Source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataModel.lists.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell!
    if let temp = tableView.dequeueReusableCell( withIdentifier: cellIdentifier) {
      cell = temp
    } else {
      cell = UITableViewCell( style: .subtitle, reuseIdentifier: cellIdentifier)
    }
    let checklist = dataModel.lists[indexPath.row]
    cell.textLabel!.text = checklist.name
    
    let uncheckedItems = checklist.countUncheckedItems()
    if checklist.items.isEmpty {
      cell.detailTextLabel!.text = "No Items"
    } else if uncheckedItems == 0  {
      cell.detailTextLabel!.text = "All Done!"
    } else {
      cell.detailTextLabel!.text = "\(uncheckedItems) Remaining"
    }
    cell.accessoryType = .detailDisclosureButton

    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let checklist = dataModel.lists[indexPath.row]
    performSegue(withIdentifier: "ShowChecklist", sender: checklist)
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    dataModel.lists.remove(at: indexPath.row)
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
    controller.delegate = self

    let list = dataModel.lists[indexPath.row]
    controller.listToEdit  = list

    navigationController?.pushViewController(controller, animated: true)
  }
  
  // MARK: - List Detail ViewController Delegates
  func listDetailViewControllerDelegateDidCancel(_ contoller: ListDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func listDetailViewController(_ contoller: ListDetailViewController, didFinishAdding list: Checklist) {
    let newRowIndex = dataModel.lists.count
    dataModel.lists.append(list)
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    navigationController?.popViewController(animated: true)
  }
  
  func listDetailViewController(_ contoller: ListDetailViewController, didFinishEditing list: Checklist) {
    if let index = dataModel.lists.firstIndex(of: list) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        cell.textLabel!.text = list.name
      }
    }
    
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowChecklist" {
      let controller = segue.destination as! CheckListViewController
      controller.checklist = sender as? Checklist
    } else if segue.identifier == "AddChecklist" {
      let controller = segue.destination as! ListDetailViewController
      controller.delegate = self
    }
  }  
}
