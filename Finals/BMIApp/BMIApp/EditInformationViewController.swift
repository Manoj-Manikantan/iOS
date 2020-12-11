//
//  EditInformationViewController.swift
//  BMIApp
//
//  Created by Manoj on 2020-12-11.
//  Copyright © 2020 Manoj. All rights reserved.
//

import Foundation
import UIKit

class EditInformationViewController: UIViewController {
    
    @IBOutlet weak var weightField: UITextField!
    
    var bmiObj = bmiInformationDetails()
    
    override func viewDidLoad() {
        weightField.text = "\(bmiObj.bmiWeight)"
    }
    
    @IBAction func updateAction(_ sender: UIButton) {
        bmiObj.bmiWeight = 0.0
        let bmiCalObj = BMICalculatorHelper()
        var updatedBmiVal = bmiCalObj.bmiValueCalc(bmiScale: bmiObj.bmiScale, bmiHeight: bmiObj.bmiHeight, bmiWeight: bmiObj.bmiWeight)
        updatedBmiVal = updatedBmiVal * 100;
        //firebase update
        navigationController?.popViewController(animated: false)
    }
}

extension EditInformationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
