//  ViewController.swift
//  Assignment5 - Todo List - Part 2
//  Name - Manoj Manikantan Muralidharan
//  Student ID - 301067347
//  Date - 26th Nov 2020
//  Description - Performs get API call and displays list of tasks
//  Redirects user to add a new task on clicking the + button
//  Also, lets the user to click on a particular task and redirect to the task information screen
//  2nd Screen lets the user to add a new task and diplays particular task details screen
//  Version 1.0

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
                }
                self.listItemTableView.reloadData()
                DispatchQueue.main.async {
                    self.listItemTableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(selectedIndex != -1)
        {
            if (segue.identifier == "addDetailSegue") {
                let detailController = segue.destination as? AddTaskViewController
                detailController!.myTaskDetails = myTaskDetailsList[selectedIndex]
            }
        }
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UIColor{
    
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTaskDetailsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listItemTableView.dequeueReusableCell(withIdentifier: "itemCell") as? ListItemTableViewCell
        cell?.taskName.text = myTaskDetailsList[indexPath.row].taskName
        if(!myTaskDetailsList[indexPath.row].dueDate.isEmpty){
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            
            let strDueDate = String(myTaskDetailsList[indexPath.row].dueDate.prefix(10))
            let currentDate = dateFormatter.string(from: Date())
            let firstDate = dateFormatter.date(from:strDueDate)
            let secondDate = dateFormatter.date(from: currentDate)
            
            cell?.taskStatus.text = strDueDate
            
            if firstDate?.compare(secondDate!) == .orderedAscending{
                cell?.taskStatus.textColor = .red
            } else {
                cell?.taskStatus.textColor = UIColor.init(displayP3Red: 0.2392, green: 0.4, blue: 0.9804, alpha: 1.0)
            }
        }else{
            cell?.taskStatus.text = "Completed"
            cell?.taskStatus.textColor = .green
        }
        if (myTaskDetailsList[indexPath.row].isCompleted) {
            cell?.taskSwitch.isOn = false
            cell?.taskSwitch.isUserInteractionEnabled = false
            cell?.backgroundColor = .lightGray
        } else {
            cell?.taskSwitch.isOn = true
            cell?.backgroundColor = .white
        }
        return cell!
    }
    
    /* Edit Operation : Left to right -> Leading swipe */
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let updateAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.selectedIndex = indexPath.row
            self.performSegue(withIdentifier: "addDetailSegue", sender: nil)
            success(true)
        })
        updateAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [updateAction])
    }
    
    /* Completed : Right to left -> Trailing Swipe */
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        
//        let completedAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            self.myTaskDetailsList[indexPath.row].isCompleted = true
//            self.myTaskDetailsList[indexPath.row].hasDueDate = false
//            self.myTaskDetailsList[indexPath.row].dueDate = ""
//            self.firebaseDb.collection("TaskDetails").document(self.myTaskDetailsList[indexPath.row].taskDocumentId).setData(self.myTaskDetailsList[indexPath.row].dictTaskDetails)
//            self.getTaskDetails()
//            print("Completed")
//            success(true)
//        })
//        completedAction.backgroundColor = .yellow
        
        let completedAction = UIContextualAction(style: .normal,
                                         title: "") { (action, view, completionHandler) in
                                            print("Completed")
                                            
        }
        completedAction.backgroundColor = .yellow
        
        let deleteAction = UIContextualAction(style: .destructive,
                                         title: "") { (action, view, completionHandler) in
                                            print("Delete")
        }
        deleteAction.backgroundColor = .red
        
//        let deleteAction = UIContextualAction(style: .destructive, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            //            self.firebaseDb.collection("TaskDetails").document(self.myTaskDetailsList[indexPath.row].taskDocumentId).delete()
//            //            self.getTaskDetails()
//            print("Delete")
//            success(true)
//        })
//        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction, completedAction])
        
        
    }
    
    
    
    
}
