//
//  AppState.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/12/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    let routingState: RoutingState
    let logState: LogState
}

