//
//  DeleteLogEntryAction.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/20/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import ReSwift

struct DeleteLogEntryAction: Action {
    let log: Log
    let logEntry: LogEntry
}
