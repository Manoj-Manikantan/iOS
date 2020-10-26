//  Project Name : MyCalculator
//  File Name : MainViewController.swift
//  Author's Name : Manoj Manikantan Muralidharan
//  Student ID : 301067347
//  Date : 25th Oct 2020
//  Assignment No 3
//  Description : Implementation of landscape orientation and additional functions
//  Version : V1.0


//  MainViewController.swift
//  MyCalculator
//  Created by Manoj on 2020-10-25.
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
    var randomDouble: Double = 0;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @IBOutlet weak var set3OperationsStackView: UIStackView!
    
    /* Makes the stack view visible in Landscape mode */
    @objc func rotated()
    {
        if UIDevice.current.orientation.isLandscape {
            set3OperationsStackView.isHidden = false
        } else {
            set3OperationsStackView.isHidden = true
        }
    }
    
    @IBAction func OnButton_Press(_ sender: UIButton)
    {
        switch sender.titleLabel!.text!
        {
        case "√":
            if((ResultLabel.text! != "0") && (ResultLabel.text! != ""))
            {
                currentNumberValue = Double(ResultLabel.text!)!
                finalResult = String(currentNumberValue.squareRoot())
                displayResult(outputVal: finalResult)
            }
        case "Rand":
            randomDouble = Double.random(in: 0.21828...9.14159)
            ResultLabel.text! = String(randomDouble)
            if (firstOperatorValue == 0)
            {
                firstOperatorValue = currentNumberValue
            }
            currentNumberValue = Double(ResultLabel.text!)!
        case "𝝅":
            ResultLabel.text! = String(Double.pi)
            if (firstOperatorValue == 0)
            {
                firstOperatorValue = currentNumberValue
            }
            currentNumberValue = Double(ResultLabel.text!)!
        case "x^2":
            if((ResultLabel.text! != "0") && (ResultLabel.text! != ""))
            {
                currentNumberValue = Double(ResultLabel.text!)!
                finalResult = String(currentNumberValue * currentNumberValue)
                displayResult(outputVal: finalResult)
            }
        case "x^y":
            if(firstOperatorValue != 0)
            {
                firstOperatorValue = calculateResult(firstVal: firstOperatorValue, secondVal: currentNumberValue, operandType: mathOperator)
            }
            mathOperationPerformed = true
            mathOperator = "^"
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
                displayResult(outputVal: finalResult)
                finalResult = ResultLabel.text!
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
            print(currentNumberValue)
            print(mathOperator)
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
        } else if(operandType == "^"){
            return(pow(firstVal, secondVal))
        } else {
            return (0)
        }
    }
    
    /* Since my output is stored in double data type, eliminating last two digits if its a whole number and displaying the final output in result label */
    func displayResult(outputVal: String)
    {
        if(outputVal.suffix(2) == ".0")
        {
            ResultLabel.text! = String(outputVal.prefix(outputVal.count-2))
        }
        else
        {
            ResultLabel.text! = outputVal
        }
        currentNumberValue = Double(ResultLabel.text!)!
    }
}
