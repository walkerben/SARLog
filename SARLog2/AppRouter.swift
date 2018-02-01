//
//  AppRouter.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/12/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import Foundation
import ReSwift

enum RoutingDestination {
    case logList
    case newLog
    case logEdit(Log)
    case logView(Log)
    case settings
    case newLogEntryType
}

extension RoutingDestination: Equatable {
    static func ==(lhs: RoutingDestination, rhs: RoutingDestination) -> Bool {
        switch(lhs, rhs) {
        case (.logList, .logList):
            return true
        case (.newLog, .newLog):
            return true
        case (let .logEdit(log1), let .logEdit(log2)):
            return log1 == log2
        case (let .logView(log1), let .logView(log2)):
            return log1 == log2
        case (.settings, .settings):
            return true
        case (.newLogEntryType, .newLogEntryType):
            return true
        default:
            return false
        }
    }
    
    
}

final class AppRouter {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        
        store.subscribe(self) { subscription in
            subscription.select { subscriptionState in
                subscriptionState.routingState
            }
        }
    }
    
    private func viewControllerFor(route: RoutingDestination) -> UIViewController {
        var vc: UIViewController
        
        switch route {
        case .logList:
            vc = LogListViewController()
        case .newLog:
            vc = NewLogViewController()
        case let .logEdit(log):
            vc = LogEditorViewController(log: log)
        case let .logView(log):
            vc = LogViewerViewController(log: log)
        case .settings:
            vc = SettingsViewController()
        case .newLogEntryType:
            vc = NewLogEntryTypeViewController()
        }
        return vc
    }
}

// MARK: - Store Subscriber
extension AppRouter: StoreSubscriber {
    func newState(state: RoutingState) {
        window.rootViewController = viewControllerFor(route: state.navigationState)
    }
}
