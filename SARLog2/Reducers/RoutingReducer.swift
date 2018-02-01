//
//  RoutingReducer.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/12/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import ReSwift

func routingReducer(action: Action, state: RoutingState?) -> RoutingState {
    var state = state ?? RoutingState()
    
    switch action {
    case let routingAction as RoutingAction:
//        if routingAction.destination != state.navigationState {
            state.navigationState = routingAction.destination
//        }
    default:
        break
    }
    return state
}
