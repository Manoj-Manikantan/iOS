//  File Name : ViewController.swift
//  Folder Name : MidTerm/MyShoppingList
//  Author's Name : Manoj Manikantan Muralidharan
//  Student ID : 301067347
//  Date : 30th Oct 2020
//  Created by Manoj on 2020-10-30.
//  Copyright © 2020 Manoj. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    var myList = [myShoppingList]()
    
    @IBOutlet weak var listItemTableView: UITableView!
    @IBOutlet weak var itemName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /* To add an item to the shopping cart list items */
    @IBAction func addItemAction(_ sender: Any) {
        if (!itemName.text!.isEmpty)
        {
            var myListItem = myShoppingList()
            myListItem.listItemName = itemName.text!
            myListItem.listQty = 1
            myList.append(myListItem)
            listItemTableView.reloadData()
        }
    }
    
    /* To change the quantity */
    @IBAction func qtyValueChanged(_ sender: UIStepper) {
        let buttonIndex = sender.tag
        myList[buttonIndex].listQty = Int(sender.value)
        listItemTableView.reloadData()
    }
    
    /* Resets the list */
    @IBAction func cancelButton(_ sender: Any) {
        myList = []
        listItemTableView.reloadData()
        itemName.text = ""
    }
    
    /* Idea is to have an edit button inside the textfield
     * 1. Disable the textfield to begin with and enable it upon clicking edit
     * 2. Change the button name to Save and allow user to edit the item
     * 3. Disable the textfield again after user enters the item and clicks save
     * 4. The button is edit again which allows user to edit
     * 5. Also update myList which stores the values
     */
    /* @IBAction func editItemName(_ sender: UIButton) {
        let idx = IndexPath(row: sender.tag, section: 0)
        let cell = listItemTableView.cellForRow(at: idx) as? ListItemCellTableViewCell
        if (sender.titleLabel!.text! == "Edit") {
            print("edit called")
            cell!.textFieldListItem.isUserInteractionEnabled = true
            cell!.editButton.titleLabel!.text! = "Save"
        }
        else if(sender.titleLabel!.text! == "Save"){
            let buttonIndex = sender.tag
            myList[buttonIndex].listItemName = "Manoj"
            cell!.textFieldListItem.isUserInteractionEnabled = false
            cell!.editButton.titleLabel!.text! = "Edit"
        }
        listItemTableView.reloadData()
    } */
}

/* To hide the keyboard when user hits return in textfields */
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

/* Table View and its functions
 * 1. To return the count
 * 2. To load the cell one by one
 */
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listItemTableView.dequeueReusableCell(withIdentifier: "itemCell") as? ListItemCellTableViewCell
        cell?.textFieldListItem.text = myList[indexPath.row].listItemName
        cell?.labelQty.text = String(myList[indexPath.row].listQty)
        cell?.stepperQty.tag = indexPath.row
        
        return cell!
    }
}

