//
//  Log.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/8/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import Foundation
import RealmSwift

class Log : Object {
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    let entries = List<LogEntry>()
}
