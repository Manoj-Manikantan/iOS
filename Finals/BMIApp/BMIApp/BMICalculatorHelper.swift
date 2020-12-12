//
//  BMICalculatorHelper.swift
//  BMIApp
//
//  Created by Manoj on 2020-12-11.
//  Copyright © 2020 Manoj. All rights reserved.
//

import Foundation

class BMICalculatorHelper {
    
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
    
    func getCurrentDate() -> String {
        let dt = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let strDate = formatter.string(from: dt)
        return strDate
    }
    
}
