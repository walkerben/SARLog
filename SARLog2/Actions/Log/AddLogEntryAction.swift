//
//  AddLogEntryAction.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/18/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import ReSwift

struct AddLogEntryAction: Action {
    let log: Log
    let logEntryType: LogEntryType
}

