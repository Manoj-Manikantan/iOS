//
//  File.swift
//  Assignment4
//
//  Created by Manoj on 2020-11-15.
//  Copyright © 2020 Manoj. All rights reserved.
//

import Foundation

struct taskInformationDetails {
    var taskName = "";
    var taskDescription = "";
    var isCompleted = false;
    var hasDueDate = false;
    var dueDate = "";
    var taskDocumentId = "";
    var dictTaskDetails: [String: Any] {
        return ["taskName": taskName,
                "taskDescription": taskDescription,
                "isCompleted": isCompleted,
                "hasDueDate": hasDueDate,
                "dueDate": dueDate,
                "taskDocumentId":taskDocumentId]
    }
    var nsDictionary: NSDictionary {
        return dictTaskDetails as NSDictionary
    }
}
