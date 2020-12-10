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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    @IBAction func MetricSegmentClicked(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            setStaticTexts(metric: true)
        }
        else {
            setStaticTexts(metric: false)
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
        
    }
    
    
}

