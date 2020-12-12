//
//  TrackingScreenViewController.swift
//  BMIApp
//
//  Created by Manoj on 2020-12-10.
//  Copyright © 2020 Manoj. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

class TrackingScreenViewController: UIViewController {
    
    @IBOutlet weak var TableViewBMI: UITableView!
    
    var listItems = [bmiInformationDetails]()
    var listItem = bmiInformationDetails()
    let firebaseDb = Firestore.firestore()
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getTaskDetails()
    }
    
    func getTaskDetails(){
        self.listItems = []
        firebaseDb.collection("bmiApp").getDocuments {(myTasks, error) in
            if(error == nil && myTasks != nil){
                for document in myTasks!.documents{
                    let taskDoc = document.data()
                    self.listItem.userName = taskDoc["userName"] as! String
                    self.listItem.userAge = taskDoc["userAge"] as? Int ?? 18
                    self.listItem.userGender = taskDoc["userGender"] as! String
                    self.listItem.bmiScale = taskDoc["bmiScale"] as! String
                    self.listItem.bmiHeight = taskDoc["bmiHeight"] as! Float
                    self.listItem.bmiWeight = taskDoc["bmiWeight"] as! Float
                    self.listItem.bmiVal = taskDoc["bmiVal"] as! Float
                    self.listItem.bmiCat = taskDoc["bmiCat"] as! String
                    self.listItem.date = taskDoc["date"] as? String ?? ""
                    self.listItem.DocumentId = taskDoc["DocumentId"] as! String
                    self.listItems.append(self.listItem)
                }
                self.TableViewBMI.reloadData()
                DispatchQueue.main.async {
                    self.TableViewBMI.reloadData()
                }
                if(self.listItems.count == 0){
                    self.navigationController?.popViewController(animated: false)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(selectedIndex != -1)
        {
            if (segue.identifier == "addDetailSegue") {
                let detailController = segue.destination as? EditInformationViewController
                detailController!.bmiObj = listItems[selectedIndex]
            }
        }
        
    }
}

extension TrackingScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as? ListItemTableViewCell
        cell?.lblWeight.text = "Weight : " + "\(listItems[indexPath.row].bmiWeight)" + ((listItems[indexPath.row].bmiScale == "Metric") ? " kgs" : " lbs")
        cell?.lblBMI.text = "BMI : " + "\(listItems[indexPath.row].bmiVal)"
        cell?.lblDate.text = "\(listItems[indexPath.row].date)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
    
    /* Delete Operation  : Right to left -> Trailing Swipe */
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        
        let deleteAction = UIContextualAction(style: .destructive, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.firebaseDb.collection("bmiApp").document(self.listItems[indexPath.row].DocumentId).delete()
            self.selectedIndex = -1
            self.getTaskDetails()
            success(true)
        })
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
