//  ViewController.swift
//  BMIApp
//
//  Created by Manoj on 2020-12-08.
//  Copyright © 2020 Manoj. All rights reserved.

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    @IBOutlet weak var txtFldName: UITextField!
    @IBOutlet weak var txtFldAge: UITextField!
    @IBOutlet weak var pckrGender: UIPickerView!
    @IBOutlet weak var txtFldHeight: UITextField!
    @IBOutlet weak var txtFldWeight: UITextField!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblBMIResult: UILabel!
    @IBOutlet weak var metricSegmentedControl: UISegmentedControl!
    @IBOutlet var bmiInfoView: UIView!
    @IBOutlet weak var bgView: UIView!
    
    let bmiCalObj = BMICalculatorHelper()
    var myBmiDetails = bmiInformationDetails()
    let firebaseDb = Firestore.firestore()
    
    var genderVal = "Male"
    var bmiScale = "Metric"
    var pickGender = ["Male", "Female"]
    var bmiVal: Float = 0
    var bmiCat = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func MetricSegmentClicked(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            bmiScale = "Imperial"
            setStaticTexts(metric: false)
        } else {
            bmiScale = "Metric"
            setStaticTexts(metric: true)
        }
    }
    
    func setStaticTexts(metric: Bool){
        if metric {
            lblHeight.text = "cms"
            lblWeight.text = "kgs"
        }
        else{
            lblHeight.text = "inches"
            lblWeight.text = "lbs"
        }
    }
    
    @IBAction func dismissInfoView(_ sender: Any) {
        bgView.isHidden = true
        bmiInfoView.isHidden = true
    }
    
    @IBAction func infoActionClicked(_ sender: UIButton) {
        bgView.isHidden = false
        bmiInfoView.isHidden = false
        self.bmiInfoView.alpha = 0.0
        UIView.animate(withDuration: 1.5, delay: 0.05 , usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.bmiInfoView.alpha = 1.0
        }, completion: nil)
    }
    
    @IBAction func btnCalculate(_ sender: Any) {
        if (inputCheck()){
            let heightVal = Float(txtFldHeight.text!)!
            let weightVal = Float(txtFldWeight.text!)!
            
            bmiVal = bmiCalObj.bmiValueCalc(bmiScale: bmiScale, bmiHeight: heightVal, bmiWeight: weightVal)
            bmiVal = (bmiVal*100).rounded()/100
            bmiCat = bmiCalObj.bmiCategoryCalc(bmiVal: bmiVal)
            lblBMIResult.text = "Your BMI is " + String(bmiVal) + " \nBMI Category : " + bmiCat
        }
    }
    
    @IBAction func btnDone(_ sender: Any) {
        if(inputCheck()){
            
            let newTaskDetail = firebaseDb.collection("bmiApp").document()
            
            myBmiDetails.userName = txtFldName.text!
            myBmiDetails.userAge = (txtFldAge.text! as NSString).integerValue
            myBmiDetails.userGender = genderVal
            myBmiDetails.bmiScale = bmiScale
            myBmiDetails.bmiHeight = (txtFldHeight.text! as NSString).floatValue
            myBmiDetails.bmiWeight = (txtFldWeight.text! as NSString).floatValue
            myBmiDetails.bmiVal = bmiVal
            myBmiDetails.bmiCat = bmiCat
            myBmiDetails.date = bmiCalObj.getCurrentDate()
            myBmiDetails.DocumentId = newTaskDetail.documentID
        
            /* Add a record */
            newTaskDetail.setData(myBmiDetails.dictBmiDetails)
            txtFldHeight.text = ""
            txtFldWeight.text = ""
            lblBMIResult.text = ""
            performSegue(withIdentifier: "addBmiRecord", sender: nil)
        }
    }
    
    func inputCheck() -> Bool{
        if ((txtFldName.text != "") && (txtFldAge.text != "") && (txtFldHeight.text != "") && (txtFldWeight.text != "") ) {
            return true
        }
        let alert = UIAlertController(title: "Inputs missing", message: "Please enter all the information to calculate the BMI ", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return false
    }
}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    /* No of columns */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /* No of rows */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickGender.count
    }
    
    /* To set the value */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickGender[row]
    }
    
    /* To fetch value */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderVal = pickGender[row]
    }
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


