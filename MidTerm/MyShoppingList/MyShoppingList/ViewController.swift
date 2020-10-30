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
    
    @IBOutlet weak var listItemTableView: UITableView!
    @IBOutlet weak var itemName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

