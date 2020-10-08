//
//  MainViewController.swift
//  MyCalculator
//
//  Created by Manoj on 2020-10-07.
//  Copyright © 2020 Manoj. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    @IBOutlet weak var ResultLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    @IBAction func OnButton_Press(_ sender: UIButton)
    {
        switch sender.titleLabel!.text! {
        case "C":
            ResultLabel.text! = (sender.titleLabel?.text)!
        case "E":
            ResultLabel.text!.popLast()
            if(ResultLabel.text!.count < 1)
            {
                ResultLabel.text! = "0"
            }
        case ".":
            if(!ResultLabel.text!.contains("."))
            {
                ResultLabel.text! += "."
            }
        case "+/-":
            print("some text")
        case "+":
            print("some text")
        case "-":
            print("some text")
        case "/":
            print("some text")
        case "x":
            print("some text")
        case "%":
            print("some text")
        default:
            if(ResultLabel.text == "0")
            {
                ResultLabel.text! = sender.titleLabel!.text!
            }
            else
            {
                ResultLabel.text! += (sender.titleLabel?.text)!
            }
        }
        
    }
    
}
