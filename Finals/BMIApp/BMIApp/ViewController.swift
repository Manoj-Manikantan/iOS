//
//  ViewController.swift
//  BMIApp
//
//  Created by Manoj on 2020-12-08.
//  Copyright © 2020 Manoj. All rights reserved.
//

import UIKit

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
    var genderVal = "Male"
    
    var pickGender = ["Male", "Female"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func MetricSegmentClicked(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            setStaticTexts(metric: false)
        }
        else {
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
        if ((txtFldName.text != "") && (txtFldAge.text != "") && (txtFldHeight.text != "") && (txtFldWeight.text != "") ) {
            
        } else {
            let alert = UIAlertController(title: "Inputs missing", message: "Please enter all the information to calculate the BMI ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func bmiValueCalc(bmiScale: String, bmiHeight: Float, bmiWeight: Float) -> Float{
        switch  bmiScale{
        case "Metric":
            return((bmiWeight)/((bmiHeight/100) * (bmiHeight/100)))
        case "Imperial":
            return((bmiWeight * 703)/(bmiHeight * bmiHeight))
        default:
            return 0
        }
    }
    
    func bmiCategoryCalc(bmiVal: Float) -> String{
        switch bmiVal {
        case ..<16:
            return "Severe Thinness"
        case 16...17:
            return "Moderate Thinness"
        case 17...18.5:
            return "Mild Thinness"
        case 18.5...25:
            return "Normal"
        case 25...30:
            return "Overweight"
        case 30...35:
            return "Obese Class I"
        case 35...40:
            return "Obese Class II"
        case 40...:
            return "Obese Class III"
        default:
            return "Index out of range"
        }
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


