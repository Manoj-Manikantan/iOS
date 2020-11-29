//  ViewController.swift
//  Assignment5 - Todo List
//  Name - Manoj Manikantan Muralidharan
//  Student ID - 301067347
//  Date - 26th Nov 2020
//  Description - Performs Add, Update and delete API calls
//  Version 1.0

//  Created by Manoj on 2020-11-26.
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
            displayTaskDetails()
        }
    }   
    
    @IBAction func dueDateSwitchPressed(_ sender: UISwitch) {
        if(sender.isOn){
            dueDatePicker.isHidden = false
        }
        else{
            dueDatePicker.isHidden = true
        }
    }
    
    func displayTaskDetails(){
        txtFldTaskName.text = myTaskDetails.taskName
        txtViewTaskDesc.text = myTaskDetails.taskDescription
        print("Is Completed")
        print(myTaskDetails.isCompleted)
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
        btnSave.setTitle("Update", for: .normal)
    }
    
    @IBAction func saveTaskDetails(_ sender: UIButton) {
        if (sender.titleLabel!.text! == "Save") {
            addTaskDetails()
            navigationController?.popViewController(animated: false)
        } else {
            let updateAlert = UIAlertController(title: "Update Task", message: "Are you sure you want to update this task?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                self.updateTaskDetails()
                self.navigationController?.popViewController(animated: false)
            })
            
            let noAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                print("Do not update")
            }
            updateAlert.addAction(yesAction)
            updateAlert.addAction(noAction)
            self.present(updateAlert, animated: true, completion: nil)
        }
    }
    
    func addTaskDetails() {
        let newTaskDetail = firebaseDb.collection("TaskDetails").document()
        myTaskDetails.taskDocumentId = newTaskDetail.documentID
        newTaskDetail.setData(myTaskDetails.dictTaskDetails)
    }
    
    func updateTaskDetails(){
        firebaseDb.collection("TaskDetails").document(myTaskDetails.taskDocumentId).setData(myTaskDetails.dictTaskDetails)
    }
    
    func checkTaskDetails(){
        if ((txtFldTaskName.text != "") && (txtFldTaskName.text != "")){
            myTaskDetails.taskName = txtFldTaskName.text!
            myTaskDetails.taskDescription = txtViewTaskDesc.text!
            if(switchIsCompleted.isOn){
                myTaskDetails.isCompleted = true
            } else {
                myTaskDetails.isCompleted = false
            }
            if(switchDueDate.isOn){
                myTaskDetails.hasDueDate = true
                dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
                myTaskDetails.dueDate = dateFormatter.string(from: dueDatePicker.date)
            } else {
                myTaskDetails.hasDueDate = false
                myTaskDetails.dueDate = ""
            }
            navigationController?.popViewController(animated: false)
        } else {
            let alert = UIAlertController(title: "Inputs missing", message: "Please enter Task name and Task Information ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteTaskDetails(_ sender: Any) {
        let deleteAlert = UIAlertController(title: "Delete Task", message: "Are you sure you want to delete this task?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.firebaseDb.collection("TaskDetails").document(self.myTaskDetails.taskDocumentId).delete()
            self.navigationController?.popViewController(animated: false)
        })
        
        let noAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Do not delete")
        }
        deleteAlert.addAction(yesAction)
        deleteAlert.addAction(noAction)
        self.present(deleteAlert, animated: true, completion: nil)
    }
    
    @IBAction func resetTaskDetails(_ sender: Any) {
        txtFldTaskName.text = ""
        txtViewTaskDesc.text = ""
        switchIsCompleted.isOn = false
        switchDueDate.isOn = false
        dueDatePicker.isHidden = true
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
