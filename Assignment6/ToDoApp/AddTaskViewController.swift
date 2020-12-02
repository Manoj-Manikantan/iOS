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

class AddTaskViewController: UIViewController {
    
    let firebaseDb = Firestore.firestore()
    var dateFormatter = DateFormatter()
    var myTaskDetails = taskInformationDetails()
    
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var txtFldTaskName: UITextField!
    @IBOutlet weak var txtViewTaskDesc: UITextView!
    @IBOutlet weak var switchIsCompleted: UISwitch!
    @IBOutlet weak var switchDueDate: UISwitch!
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (!myTaskDetails.taskDocumentId.isEmpty) {
            print(myTaskDetails.taskDocumentId)
            btnSave.setTitle("Update", for: .normal)
            displayTaskDetails()
        }
    }
    
    @IBAction func isCompletedSwitchPressed(_ sender: UISwitch) {
        if(sender.isOn){
            switchDueDate.isOn = false
            dueDatePicker.isHidden = true
        }
    }
    
    @IBAction func dueDateSwitchPressed(_ sender: UISwitch) {
        if(sender.isOn){
            switchIsCompleted.isOn = false
            dueDatePicker.isHidden = false
        }
        else{
            dueDatePicker.isHidden = true
        }
    }
    
    func displayTaskDetails(){
        txtFldTaskName.text = myTaskDetails.taskName
        txtViewTaskDesc.text = myTaskDetails.taskDescription
        if(myTaskDetails.isCompleted){
            switchIsCompleted.isOn = true
        }
        else{
            switchIsCompleted.isOn = false
        }
        if(myTaskDetails.hasDueDate){
            switchDueDate.isOn = true
            dueDatePicker.setDate(from: myTaskDetails.dueDate, format: "MM/dd/yyyy HH:mm:ss", animated: true)
            dueDatePicker.isHidden = false
        }
    }
    
    @IBAction func saveTaskDetails(_ sender: UIButton) {
        if (sender.titleLabel!.text! == "Save") {
            addTaskDetails()
        } else {
            let updateAlert = UIAlertController(title: "Update Task", message: "Are you sure you want to update this task?", preferredStyle: .actionSheet)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
                self.checkTaskDetails()
                self.updateTaskDetails()
                self.myTaskDetails.taskDocumentId = ""
                self.navigationController?.popViewController(animated: false)
            })
            
            let noAction = UIAlertAction(title: "No", style: .cancel) { (action) -> Void in
                print("Do not update")
            }
            
            updateAlert.addAction(yesAction)
            updateAlert.addAction(noAction)
            self.present(updateAlert, animated: true, completion: nil)
        }
    }
    
    func checkTaskDetails(){
        if ((txtFldTaskName.text != "") && (txtFldTaskName.text != "")){
            myTaskDetails.taskName = txtFldTaskName.text!
            myTaskDetails.taskDescription = txtViewTaskDesc.text!
            if(switchIsCompleted.isOn){
                myTaskDetails.isCompleted = true
                switchDueDate.isOn = false
                dueDatePicker.isHidden = true
                myTaskDetails.hasDueDate = false
                myTaskDetails.dueDate = ""
            } else {
                myTaskDetails.isCompleted = false
            }
            if(switchDueDate.isOn){
                myTaskDetails.hasDueDate = true
                dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
                myTaskDetails.dueDate = dateFormatter.string(from: dueDatePicker.date)
            }
        } else {
            let alert = UIAlertController(title: "Inputs missing", message: "Please enter Task name and Task Information ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func addTaskDetails() {
        checkTaskDetails()
        let newTaskDetail = firebaseDb.collection("TaskDetails").document()
        myTaskDetails.taskDocumentId = newTaskDetail.documentID
        newTaskDetail.setData(myTaskDetails.dictTaskDetails)
        myTaskDetails.taskDocumentId = ""
        navigationController?.popViewController(animated: false)
    }
    
    func updateTaskDetails(){
        firebaseDb.collection("TaskDetails").document(myTaskDetails.taskDocumentId).setData(myTaskDetails.dictTaskDetails)
    }
    
    @IBAction func deleteTaskDetails(_ sender: Any) {
        let deleteAlert = UIAlertController(title: "Delete Task", message: "Are you sure you want to delete this task?", preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            self.firebaseDb.collection("TaskDetails").document(self.myTaskDetails.taskDocumentId).delete()
            self.myTaskDetails.taskDocumentId = ""
            self.navigationController?.popViewController(animated: false)
        })
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (action) -> Void in
            print("Do not delete")
        }
        
        deleteAlert.addAction(yesAction)
        deleteAlert.addAction(noAction)
        self.present(deleteAlert, animated: true, completion: nil)
    }
    
    @IBAction func resetTaskDetails(_ sender: Any) {
        let cancelAlert = UIAlertController(title: "Cancel Task", message: "Are you sure you want to discard the changes?", preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Yes, Rollback to initial values", style: .default, handler: { (action) -> Void in
            self.displayTaskDetails()
        })
        
        let noAction = UIAlertAction(title: "No, Continue Editing", style: .cancel) { (action) -> Void in
            print("Continue editing")
        }
        cancelAlert.addAction(yesAction)
        cancelAlert.addAction(noAction)
        self.present(cancelAlert, animated: true, completion: nil)
    }
}

extension UIDatePicker {
    
    func setDate(from string: String, format: String, animated: Bool = true) {
        let formater = DateFormatter()
        formater.dateFormat = format
        let date = formater.date(from: string) ?? Date()
        setDate(date, animated: animated)
    }
}
