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
}
