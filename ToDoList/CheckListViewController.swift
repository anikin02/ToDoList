//
//  CheckListViewController.swift
//  ToDoList
//
//  Created by anikin02 on 28.08.2023.
//

import UIKit

class CheckListViewController: UITableViewController {
  
  var items: [CheckListItem] = [CheckListItem]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    items.append(CheckListItem(Lable: "Buy big house"))
    items.append(CheckListItem(Lable: "Buy iPhone"))
    items.append(CheckListItem(Lable: "Earn a lot of money"))
    items.append(CheckListItem(Lable: "Earn a money"))
    items.append(CheckListItem(Lable: "Earn MONEY"))
  }

  // MARK: - Table view data source

//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
  
  func configureCheckmark(for cell: UITableViewCell, with item: CheckListItem) {
    if item.Checked {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
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
  
  // MARK: - Table view delegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if let cell = tableView.cellForRow(at: indexPath) {
      if cell.accessoryType == .none {
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
    }
  }

  /*
  // Override to support conditional editing of the table view.
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      // Return false if you do not want the specified item to be editable.
      return true
  }
  */

  /*
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          // Delete the row from the data source
          tableView.deleteRows(at: [indexPath], with: .fade)
      } else if editingStyle == .insert {
          // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
      }
  }
  */

  /*
  // Override to support rearranging the table view.
  override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

  }
  */

  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
      // Return false if you do not want the item to be re-orderable.
      return true
  }
  */

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }
  */

}
