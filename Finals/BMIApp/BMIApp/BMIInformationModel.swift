//
//  BMIInformationModel.swift
//  BMIApp
//
//  Created by Manoj on 2020-12-11.
//  Copyright © 2020 Manoj. All rights reserved.

import Foundation

struct bmiInformationDetails {
    var userName = "";
    var userAge = 0;
    var userGender = "";
    var bmiScale = "";
    var bmiHeight: Float = 0.0;
    var bmiWeight: Float = 0.0;
    var bmiVal: Float = 0.0;
    var bmiCat = "";
    var date = "";
    var DocumentId = "";
    var dictBmiDetails: [String: Any] {
        return ["userName": userName,
                "userAge": userAge,
                "userGender": userGender,
                "bmiScale": bmiScale,
                "bmiHeight": bmiHeight,
                "bmiWeight":bmiWeight,
                "bmiVal": bmiVal,
                "bmiCat":bmiCat,
                "date":date,
                "DocumentId":DocumentId]
    }
    var nsDictionary: NSDictionary {
        return dictBmiDetails as NSDictionary
    }
}
