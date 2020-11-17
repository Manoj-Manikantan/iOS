//
//  ViewController.swift
//  Assignment4 - Todo List
//  Name - Manoj Manikantan Muralidharan
//  Student ID - 301067347
//  Date - 14th Nov 2020
//  Description - Two create UI part of two screens of the ToDo App
//  1st Screen will hold the list of tasks
//  2nd Screen will allow the user to enter task details


//  Created by Manoj on 2020-11-12.
//  Copyright © 2020 Manoj. All rights reserved.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var listItemTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

/* To hide the keyboard when user hits return in textfields */
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
