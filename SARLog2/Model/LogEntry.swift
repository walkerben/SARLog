//
//  LogEntry.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/8/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import Foundation
import RealmSwift

class LogEntry: Object {
    // Time
    @objc dynamic var time = NSDate()
    // Lat
    @objc dynamic var latitude = 0.0
    // Long
    @objc dynamic var longitude = 0.0
    // Entry type
//    @objc dynamic var type = LogEntryType()
    // Notes
    @objc dynamic var notes = ""
}
