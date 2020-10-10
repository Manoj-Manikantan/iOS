//  Project Name : MyCalculator
//  File Name : MainViewController.swift
//  Author's Name : Manoj Manikantan Muralidharan
//  Student ID : 301067347
//  Date : 9th Oct 2020
//  Description : Functioning of Basic Calculator Functions
//  Version : V1.0


//  MainViewController.swift
//  MyCalculator
//  Created by Manoj on 2020-10-07.
//  Copyright © 2020 Manoj. All rights reserved.

import UIKit

class MainViewController: UIViewController
{
    @IBOutlet weak var ResultLabel: UILabel!
    
    var currentNumberValue: Double = 0; /* To store user input values */
    var firstOperatorValue: Double = 0; /* To hold the first set of values (e.x) 1(operator1 value always) + 2 */
    var mathOperationPerformed: Bool = false; /* Returns true whenever math operator is pressed */
    var mathOperator: String = ""; /* To store math operators */
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
                _ = ResultLabel.text!.popLast()
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
                if((ResultLabel.text! != "0") && (ResultLabel.text! != "") && (ResultLabel.text! != finalResult))
                {
                    finalResult = String(calculateResult(firstVal: firstOperatorValue, secondVal: currentNumberValue, operandType: mathOperator))
                    if(finalResult.suffix(2) == ".0") /* Since my output is stored in double data type, eliminating last two digits if its a whole number */
                    {
                        ResultLabel.text! = String(finalResult.prefix(finalResult.count-2))
                    }
                    else
                    {
                        ResultLabel.text! = finalResult
                    }
                    finalResult = ResultLabel.text!
                    currentNumberValue = Double(ResultLabel.text!)!
                    firstOperatorValue = 0
                    print(ResultLabel.text!)
                    print(finalResult)
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
    
    /* Calculates the value of operator 1, operator 2 with any operation type and returns the value as double */
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
