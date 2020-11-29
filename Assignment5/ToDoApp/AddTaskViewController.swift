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
    
    var myTaskDetails = taskInformationDetails()
    
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var txtFldTaskName: UITextField!
    @IBOutlet weak var txtViewTaskDesc: UITextView!
    @IBOutlet weak var switchIsCompleted: UISwitch!
    @IBOutlet weak var switchDueDate: UISwitch!
    @IBOutlet weak var btnSave: UIButton!
    
    var dateFormatter = DateFormatter()
    
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
    }
    
    @IBAction func saveTaskDetails(_ sender: UIButton) {
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
                       }
                       addTaskDetails()
                navigationController?.popViewController(animated: false)
            } else {
                let alert = UIAlertController(title: "Inputs missing", message: "Please enter Task name and Task Information to save a task", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    func addTaskDetails() {
        let firebaseDb = Firestore.firestore()
        let newTaskDetail = firebaseDb.collection("TaskDetails").document()
        myTaskDetails.taskDocumentId = newTaskDetail.documentID
        newTaskDetail.setData(myTaskDetails.dictTaskDetails)
    }
    
    
    @IBAction func deleteTaskDetails(_ sender: Any) {
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
