//
//  ViewController.swift
//  Assignment4 - Todo List
//  Name - Manoj Manikantan Muralidharan
//  Student ID - 301067347
//  Date - 14th Nov 2020
//  Description - Two create UI part of two screens of the ToDo App
//  1st Screen will hold the list of tasks
//  2nd Screen will allow the user to enter task details


//  Created by Manoj on 2020-11-12.
//  Copyright © 2020 Manoj. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    var myTask = [taskInformationDetails]()
    @IBOutlet weak var listItemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

/* To hide the keyboard when user hits return in textfields */
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myTask.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listItemTableView.dequeueReusableCell(withIdentifier: "itemCell") as? ListItemTableViewCell
        cell?.taskName.text = "Task 1"
        cell?.taskStatus.text = "Completed"
        return cell!
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        let modifyAction = UIContextualAction(style: .normal, title:  "Update", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            success(true)
        })
        modifyAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
    
}
