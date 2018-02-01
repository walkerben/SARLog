//
//  LogReducer.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/12/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import ReSwift
import RealmSwift

func logReducer(action: Action, state: LogState?) -> LogState {
    let state = state ?? LogState()
    
    switch action {
    case let createNewLogAction as CreateNewLogAction:
        do {
            try state.realm.write {
                state.realm.add(createNewLogAction.log)
            }
            print("Added new log to database.")
        } catch {
            print("Error adding log to database.")
        }
    case let createNewLogEntryType as CreateNewLogEntryTypeAction:
        do {
            try state.realm.write {
                state.realm.add(createNewLogEntryType.logEntryType)
            }
            print("Added new log entry type to database.")
        } catch {
            print("Error adding log entry type to database.")
        }
    case let addLogEntryAction as AddLogEntryAction:
        let logEntry = LogEntry()
        logEntry.notes = addLogEntryAction.logEntryType.name
        
        do {
            try state.realm.write {
                addLogEntryAction.log.entries.append(logEntry)
            }
        } catch {
            print("Error adding log entry to log.")
        }
    case let deleteLogAction as DeleteLogAction:
        do {
            try state.realm.write {
                for logEntry in deleteLogAction.log.entries {
                    state.realm.delete(logEntry)
                }
                state.realm.delete(deleteLogAction.log)
            }
        } catch {
            print("Error deleting log from the database.")
        }
    case let deleteLogEntryAction as DeleteLogEntryAction:
        do {
            try state.realm.write {
                state.realm.delete(deleteLogEntryAction.logEntry)
            }
        } catch {
            print("Error deleting log entry from log.")
        }
    default:
        break
    }
    
    return state
}
