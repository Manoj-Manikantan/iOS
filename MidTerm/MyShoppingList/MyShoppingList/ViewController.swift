//
//  ViewController.swift
//  MyShoppingList
//
//  Created by Manoj on 2020-10-30.
//  Copyright © 2020 Manoj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myList = [myShoppingList]()
    var tableCell = ListItemCellTableViewCell()
    
    @IBOutlet weak var listItemTableView: UITableView!
    @IBOutlet weak var itemName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
    
    @IBAction func qtyValueChanged(_ sender: UIStepper) {
        let buttonIndex = sender.tag
        myList[buttonIndex].listQty = Int(sender.value)
        listItemTableView.reloadData()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        myList = []
        listItemTableView.reloadData()
        itemName.text = ""
    }
    
    @IBAction func editItemName(_ sender: UIButton) {
        if (sender.titleLabel!.text! == "Edit") {
            print("edit called")
//            print(tableCell.textFieldListItem.text!)
//            tableCell.textFieldListItem.isEnabled = true
//            tableCell.textFieldListItem.isUserInteractionEnabled = true
//            sender.titleLabel!.text! = "Save"
        }
//        else if(sender.titleLabel!.text! == "Save"){
//            let buttonIndex = sender.tag
//            myList[buttonIndex].listItemName = "Manoj"
//            tableCell.textFieldListItem.isEnabled = false
//            tableCell.textFieldListItem.isUserInteractionEnabled = false
//            sender.titleLabel!.text! = "Edit"
//            listItemTableView.reloadData()
//        }
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


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

