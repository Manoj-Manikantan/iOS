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
    
    var currentNumberValue: Double = 0;
    var firstOperatorValue: Double = 0;
    var mathOperationPerformed: Bool = false;
    var mathOperator: String = "";
    var finalResult: String = "";
    
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
                firstOperatorValue = 0
                currentNumberValue = 0
                mathOperationPerformed = false
            case "E":
                ResultLabel.text!.popLast()
                if(ResultLabel.text!.count < 1)
                {
                    ResultLabel.text! = "0"
                }
                else
                {
                    currentNumberValue = Double(ResultLabel.text!)!
                }
            case ".":
                if(!ResultLabel.text!.contains("."))
                {
                    ResultLabel.text! += "."
                }
            case "+/-":
                if((ResultLabel.text! != "0") && (ResultLabel.text! != ""))
                {
                    if(Int(ResultLabel.text!)! > 0)
                    {
                        ResultLabel.text! = "-" + ResultLabel.text!
                    }
                    else
                    {
                        ResultLabel.text! = String(abs(Int(ResultLabel.text!)!))
                    }
                    currentNumberValue = Double(ResultLabel.text!)!
                }
            case "+":
                if(firstOperatorValue != 0)
                {
                    firstOperatorValue = calculateResult(firstVal: firstOperatorValue, secondVal: currentNumberValue, operandType: mathOperator)
                }
                mathOperationPerformed = true
                mathOperator = "+"
            case "-":
                if(firstOperatorValue != 0)
                {
                    firstOperatorValue = calculateResult(firstVal: firstOperatorValue, secondVal: currentNumberValue, operandType: mathOperator)
                }
                mathOperationPerformed = true
                mathOperator = "-"
            case "/":
                if(firstOperatorValue != 0)
                {
                    firstOperatorValue = calculateResult(firstVal: firstOperatorValue, secondVal: currentNumberValue, operandType: mathOperator)
                }
                mathOperationPerformed = true
                mathOperator = "/"
            case "x":
                if(firstOperatorValue != 0)
                {
                    firstOperatorValue = calculateResult(firstVal: firstOperatorValue, secondVal: currentNumberValue, operandType: mathOperator)
                }
                mathOperationPerformed = true
                mathOperator = "x"
            case "%":
                ResultLabel.text! = String(currentNumberValue/100)
                currentNumberValue = Double(ResultLabel.text!)!
            case "=":
                if((ResultLabel.text! != "0") && (ResultLabel.text! != "") && (ResultLabel.text! != String(currentNumberValue)))
                {
                    finalResult = String(calculateResult(firstVal: firstOperatorValue, secondVal: currentNumberValue, operandType: mathOperator))
                    if(finalResult.suffix(2) == ".0")
                    {
                        ResultLabel.text! = String(finalResult.prefix(finalResult.count-2))
                    }
                    else
                    {
                        ResultLabel.text! = finalResult
                    }
                    currentNumberValue = Double(ResultLabel.text!)!
                    firstOperatorValue = 0
                }
            default:
                if (ResultLabel.text == "0")
                {
                    ResultLabel.text! = sender.titleLabel!.text!
                    if (currentNumberValue == 0)
                    {
                        currentNumberValue = Double(ResultLabel.text!)!
                    }
                }
                else
                {
                    if (mathOperationPerformed == false)
                    {
                        ResultLabel.text! += sender.titleLabel!.text!
                        currentNumberValue = Double(ResultLabel.text!)!
                    }
                    else
                    {
                        if (firstOperatorValue == 0)
                        {
                            firstOperatorValue = currentNumberValue
                        }
                        ResultLabel.text! = sender.titleLabel!.text!
                        currentNumberValue = Double(ResultLabel.text!)!
                        mathOperationPerformed = false
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
