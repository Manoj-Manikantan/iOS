//
//  AddTaskViewController.swift
//  Assignment4
//
//  Created by Manoj on 2020-11-14.
//  Copyright © 2020 Manoj. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func dueDateSwitchPressed(_ sender: UISwitch) {
        if(sender.isOn){
            dueDatePicker.isHidden = false
        }
        else{
            dueDatePicker.isHidden = true
        }
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
