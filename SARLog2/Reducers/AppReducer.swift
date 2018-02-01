//
//  AppReducer.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/12/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        routingState: routingReducer(action: action, state: state?.routingState),
        logState: logReducer(action: action, state: state?.logState)
    )
}
