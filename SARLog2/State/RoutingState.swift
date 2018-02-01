//
//  RoutingState.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/12/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import ReSwift

struct RoutingState: StateType {
    var navigationState: RoutingDestination
    
    init(navigationState: RoutingDestination = .logList) {
        self.navigationState = navigationState
    }
}

extension RoutingState: Equatable {
    static func ==(lhs: RoutingState, rhs: RoutingState) -> Bool {
        return lhs.navigationState == rhs.navigationState
    }
}

