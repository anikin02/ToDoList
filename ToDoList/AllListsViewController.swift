//
//  AllListsViewController.swift
//  ToDoList
//
//  Created by anikin02 on 07.09.2023.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
  let cellIdentifier = "ChecklistCell"
  var lists: [Checklist] = [Checklist]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    loadChecklists()
  }
  
  // MARK: - Table View Data Source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return lists.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    let checklist = lists[indexPath.row]
    cell.textLabel!.text = checklist.name
    cell.accessoryType = .detailDisclosureButton
    cell.tintColor = UIColor.systemPink // Recolor!!!

    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let checklist = lists[indexPath.row]
    performSegue(withIdentifier: "ShowChecklist", sender: checklist)
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    lists.remove(at: indexPath.row)
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
    controller.delegate = self

    let list = lists[indexPath.row]
    controller.listToEdit  = list

    navigationController?.pushViewController(controller, animated: true)
  }
  
  // MARK: - List Detail ViewController Delegates
  func listDetailViewControllerDelegateDidCancel(_ contoller: ListDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func listDetailViewController(_ contoller: ListDetailViewController, didFinishAdding list: Checklist) {
    let newRowIndex = lists.count
    lists.append(list)
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    navigationController?.popViewController(animated: true)
  }
  
  func listDetailViewController(_ contoller: ListDetailViewController, didFinishEditing list: Checklist) {
    if let index = lists.firstIndex(of: list) {
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
  
  // MARK: - Data Saving
  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }

  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("ToDoList.plist")
  }
  
  func saveChecklists() {
    let encoder = PropertyListEncoder()
    do {
      let data = try encoder.encode(lists)
      try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
    } catch {
      print("Error encoding list array: \(error.localizedDescription)")
    }
  }
  
  func loadChecklists() {
    let path = dataFilePath()
    if let data = try? Data(contentsOf: path) {
      let decoder = PropertyListDecoder()
      do {
        lists = try decoder.decode([Checklist].self, from: data)
      } catch {
        print("Error decoding list array: \(error.localizedDescription)")
      }
    }
  }
}
