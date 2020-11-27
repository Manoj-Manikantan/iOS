//  AddTaskViewController.swift
//  Assignment5

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
    }
    
    
    @IBAction func dueDateSwitchPressed(_ sender: UISwitch) {
        if(sender.isOn){
            dueDatePicker.isHidden = false
        }
        else{
            dueDatePicker.isHidden = true
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
                           print(myTaskDetails.hasDueDate)
                           dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
                           myTaskDetails.dueDate = dateFormatter.string(from: dueDatePicker.date)
                           print(dateFormatter.string(from: dueDatePicker.date))
                       } else {
                           myTaskDetails.hasDueDate = false
                       }
                       addTaskDetails()
                navigationController?.popViewController(animated: false)
            }
    }
    
    func addTaskDetails() {
        let firebaseDb = Firestore.firestore()
        let newTaskDetail = firebaseDb.collection("TaskDetails").document()
        myTaskDetails.taskDocumentId = newTaskDetail.documentID
        newTaskDetail.setData(myTaskDetails.dictTaskDetails)
        print(myTaskDetails)
        print("Task details added")
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
