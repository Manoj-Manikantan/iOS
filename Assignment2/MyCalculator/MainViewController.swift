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
    
    var onScreenNumberValue: Double = 0;
    var firstValue: Double = 0;
    var mathOperatorPerformed: Bool = false;
    var mathOperator: String = "";
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    @IBAction func OnButton_Press(_ sender: UIButton)
    {
        switch sender.titleLabel!.text!
        {
            case "C":
                ResultLabel.text! = "0"
                firstValue = 0;
                mathOperatorPerformed = false
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
                mathOperatorPerformed = true
                if(firstValue != 0)
                {
                    mathOperator = "+"
                    firstValue = calculateResult(firstVal: firstValue, secondVal: onScreenNumberValue, operandType: mathOperator)
                }
            case "-":
                mathOperatorPerformed = true
                if(firstValue != 0)
                {
                    mathOperator = "-"
                    firstValue = calculateResult(firstVal: firstValue, secondVal: onScreenNumberValue, operandType: mathOperator)
                }
            case "/":
                mathOperatorPerformed = true
                if(firstValue != 0)
                {
                    mathOperator = "/"
                    firstValue = calculateResult(firstVal: firstValue, secondVal: onScreenNumberValue, operandType: mathOperator)
                }
            case "x":
                mathOperatorPerformed = true
                if(firstValue != 0)
                {
                    mathOperator = "x"
                    firstValue = calculateResult(firstVal: firstValue, secondVal: onScreenNumberValue, operandType: mathOperator)
                }
            case "%":
                ResultLabel.text! = String(onScreenNumberValue/100)
            case "=":
                 firstValue = calculateResult(firstVal: firstValue, secondVal: onScreenNumberValue, operandType: mathOperator)
                 ResultLabel.text! = String(firstValue)
                mathOperatorPerformed = true
            default:
                if(ResultLabel.text == "0")
                {
                    ResultLabel.text! = sender.titleLabel!.text!
                }
                else
                {
                    if (mathOperatorPerformed != true)
                    {
                        ResultLabel.text! += sender.titleLabel!.text!
                        onScreenNumberValue = ((ResultLabel.text)! as NSString).doubleValue
                    }
                    else
                    {
                        if (firstValue == 0)
                        {
                            firstValue = onScreenNumberValue
                        }
                        ResultLabel.text! = sender.titleLabel!.text!
                        onScreenNumberValue = ((ResultLabel.text)! as NSString).doubleValue
                        mathOperatorPerformed = false
                    }
                }
        }
    }
    
    func calculateResult(firstVal: Double, secondVal: Double, operandType: String) -> Double
    {
        if (operandType == "+")
        {
            return(firstVal + secondVal)
        } else if(operandType == "-")
        {
            return(firstVal - secondVal)
        } else if(operandType == "/")
        {
            return(firstVal / secondVal)
        } else if(operandType == "x")
        {
            return(firstVal * secondVal)
        } else {
            return (0)
        }
    }
}
