//  EditInformationViewController.swift
//  BMIApp

//  Created by Manoj on 2020-12-11.
//  Copyright © 2020 Manoj. All rights reserved.

import Foundation
import UIKit
import FirebaseFirestore

class EditInformationViewController: UIViewController {
    
    let firebaseDb = Firestore.firestore()
    let bmiCalObj = BMICalculatorHelper()
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var lblWeightMetric: UILabel!
    
    var bmiObj = bmiInformationDetails()
    
    override func viewDidLoad() {
        weightField.text = "\(bmiObj.bmiWeight)"
        if (bmiObj.bmiScale == "Metric") {
            lblWeightMetric.text = "kgs"
        } else {
            lblWeightMetric.text = "lbs"
        }
    }
    
    @IBAction func updateAction(_ sender: UIButton) {
        bmiObj.bmiWeight = Float(weightField.text!) ?? 0.0
        
        var updatedBmiVal = bmiCalObj.bmiValueCalc(bmiScale: bmiObj.bmiScale, bmiHeight: bmiObj.bmiHeight, bmiWeight: bmiObj.bmiWeight)
        updatedBmiVal = (updatedBmiVal*100).rounded()/100
        bmiObj.bmiVal = updatedBmiVal
        bmiObj.bmiCat = bmiCalObj.bmiCategoryCalc(bmiVal: updatedBmiVal)
        bmiObj.date = bmiCalObj.getCurrentDate()
        
        /* Update latest weight, BMI value, BMI category and the date */
        firebaseDb.collection("bmiApp").document(bmiObj.DocumentId).setData(bmiObj.dictBmiDetails)
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        weightField.text = String(bmiObj.bmiWeight)
    }
    
}

extension EditInformationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
