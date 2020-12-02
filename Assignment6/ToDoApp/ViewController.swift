//  ViewController.swift
//  Assignment6 - Todo List - Part 3
//  Name - Manoj Manikantan Muralidharan
//  Student ID - 301067347
//  Date - 2nd Dec 2020
//  Description - Gesture Control
//  User swipes from left to right => Edit
//  User swipes from right to left => Mark as Complete
//  User long swipes from right to left => Delete
//  Version 1.1
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
            cell?.backgroundColor = .lightGray
        } else {
            cell?.backgroundColor = .white
        }
        
        return cell!
    }
    
    /* Edit Operation : Left to right -> Leading swipe */
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let updateAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
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
        
        let completedAction = UIContextualAction(style: .normal, title:  "Completed", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.myTaskDetailsList[indexPath.row].isCompleted = true
            self.myTaskDetailsList[indexPath.row].hasDueDate = false
            self.myTaskDetailsList[indexPath.row].dueDate = ""
            self.firebaseDb.collection("TaskDetails").document(self.myTaskDetailsList[indexPath.row].taskDocumentId).setData(self.myTaskDetailsList[indexPath.row].dictTaskDetails)
            self.selectedIndex = -1
            self.getTaskDetails()
            success(true)
        })
        completedAction.backgroundColor = .yellow
        
        
        let deleteAction = UIContextualAction(style: .destructive, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.firebaseDb.collection("TaskDetails").document(self.myTaskDetailsList[indexPath.row].taskDocumentId).delete()
            self.selectedIndex = -1
            self.getTaskDetails()
            success(true)
        })
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction, completedAction])
    }
    
}
