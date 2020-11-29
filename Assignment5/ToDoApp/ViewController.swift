//  ViewController.swift
//  Assignment5 - Todo List
//  Name - Manoj Manikantan Muralidharan
//  Student ID - 301067347
//  Date - 26th Nov 2020
//  Description - Two create UI part of two screens of the ToDo App
//  1st Screen will hold the list of tasks
//  2nd Screen will allow the user to enter task details


//  Created by Manoj on 2020-11-26.
//  Copyright © 2020 Manoj. All rights reserved.

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    var myTaskDetailsList = [taskInformationDetails]()
    var myTaskDetails = taskInformationDetails()
    let firebaseDb = Firestore.firestore()
    var selectedIndex = -1
    
    @IBOutlet weak var listItemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getTaskDetails()
    }
    
    func getTaskDetails(){
        self.myTaskDetailsList = []
        firebaseDb.collection("TaskDetails").getDocuments { (myTasks, error) in
            if(error == nil && myTasks != nil){
                for document in myTasks!.documents{
                    let taskDoc = document.data()
                    self.myTaskDetails.taskName = taskDoc["taskName"] as! String
                    self.myTaskDetails.taskDescription = taskDoc["taskDescription"] as! String
                    self.myTaskDetails.isCompleted = taskDoc["isCompleted"] as! Bool
                    self.myTaskDetails.hasDueDate = taskDoc["hasDueDate"] as! Bool
                    self.myTaskDetails.dueDate = taskDoc["dueDate"] as! String
                    self.myTaskDetails.taskDocumentId = taskDoc["taskDocumentId"] as! String
                    self.myTaskDetailsList.append(self.myTaskDetails)
                    print("Document")
                    print(self.myTaskDetails)
                }
                DispatchQueue.main.async {
                    self.listItemTableView.reloadData()
                }
            }
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(selectedIndex != -1)
        {
            print(selectedIndex)
            if segue.identifier == "addDetailSegue" {
                let detailController = segue.destination as? AddTaskViewController
                detailController!.myTaskDetails = myTaskDetailsList[selectedIndex]
            }
        }
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
        return myTaskDetailsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listItemTableView.dequeueReusableCell(withIdentifier: "itemCell") as? ListItemTableViewCell
        cell?.taskName.text = myTaskDetailsList[indexPath.row].taskName
        if(!myTaskDetailsList[indexPath.row].dueDate.isEmpty){
            cell?.taskStatus.text = myTaskDetailsList[indexPath.row].dueDate
        }else{
            cell?.taskStatus.text = myTaskDetailsList[indexPath.row].taskDescription
        }
        cell?.taskStatus.text = myTaskDetailsList[indexPath.row].taskDescription
        if (myTaskDetailsList[indexPath.row].isCompleted) {
            cell?.taskSwitch.isOn = false
            cell?.taskSwitch.isUserInteractionEnabled = false
            cell?.backgroundColor = .lightGray
        } else {
             cell?.taskSwitch.isOn = true
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        
        let updateAction = UIContextualAction(style: .normal, title:  "Update", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.selectedIndex = indexPath.row
            self.performSegue(withIdentifier: "addDetailSegue", sender: nil)
            success(true)
        })
//        updateAction.image = Update
        updateAction.backgroundColor = .darkGray
        
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            success(true)
        })
//        updateAction.image = #imageLiteral(resourceName: <#T##String#>)
        updateAction.backgroundColor = .darkGray
        
        return UISwipeActionsConfiguration(actions: [updateAction,deleteAction])
    }
}
