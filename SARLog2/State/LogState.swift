//
//  LogState.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/12/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import ReSwift
import RealmSwift

struct LogState: StateType {
    let realm = try! Realm()
    let logs: Results<Log>
    let logEntryTypes: Results<LogEntryType>
    
    init() {
        logs = realm.objects(Log.self)
        logEntryTypes = realm.objects(LogEntryType.self)
    }
}
