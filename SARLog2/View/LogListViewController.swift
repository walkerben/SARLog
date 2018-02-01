//
//  LogListViewController.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/6/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import UIKit
import Cartography
import RxSwift
import RxRealmDataSources

class LogListViewController: UIViewController {
    let titleView = UILabel()
    let newLogButton = UIButton(type: .roundedRect)
    let settingsButton = UIButton(type: .roundedRect)
    let logTableView = UITableView()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        
        newLogButton.addTarget(self, action: #selector(self.newLogTapped), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(self.settingsTapped), for: .touchUpInside)
        
        logTableView.delegate = self
        
        // Register a cell for the table view
        logTableView.register(UITableViewCell.self, forCellReuseIdentifier: "logCell")
        
        // Create the data source
        let dataSource = RxTableViewRealmDataSource<Log>(cellIdentifier: "logCell", cellType: UITableViewCell.self) {
            cell, indexPath, log in
            cell.textLabel?.text = log.name
            cell.detailTextLabel?.text = log.date.description
        }
        
        // bind the data source to the table view
        let logs = Observable.changeset(from: store.state.logState.logs).share()
        logs
            .bind(to: logTableView.rx.realmChanges(dataSource))
            .disposed(by: disposeBag)
        
        // React to cell taps
        logTableView.rx.realmModelSelected(Log.self)
            .subscribe(onNext: { log in
                store.dispatch(RoutingAction(destination: .logEdit(log)))
            })
            .disposed(by: disposeBag)
    }
    
    @objc func newLogTapped() {
        store.dispatch(RoutingAction(destination: .newLog))
    }
    
    @objc func settingsTapped() {
        store.dispatch(RoutingAction(destination: .settings))
    }
}

// MARK: - View Configuration
private extension LogListViewController {
    func configureViews() {
        // View Hierarchy
        view.addSubview(titleView)
        view.addSubview(logTableView)
        view.addSubview(newLogButton)
        view.addSubview(settingsButton)
        
        // Style
        view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 1.0, alpha: 1.0)
        
        titleView.text = "SAR Logs"
        titleView.textColor = UIColor.white
        titleView.backgroundColor = UIColor.clear
        titleView.textAlignment = .center
        
        logTableView.backgroundColor = UIColor.white
        logTableView.alpha = 0.9
        
        newLogButton.backgroundColor = UIColor.blue
        newLogButton.setTitle("+", for: .normal)
        newLogButton.setTitleColor(UIColor.white, for: .normal)
        newLogButton.layer.cornerRadius = 25
        newLogButton.layer.shadowColor = UIColor.gray.cgColor
        newLogButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        settingsButton.backgroundColor = UIColor.red
        settingsButton.setTitleColor(UIColor.white, for: .normal)
        settingsButton.setTitle("*", for: .normal)
        settingsButton.layer.cornerRadius = 25
        settingsButton.layer.shadowColor = UIColor.gray.cgColor
        settingsButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        // Layout
        constrain(titleView, view) { titleView, view in
            titleView.top == view.topMargin + 10
            titleView.left == view.leftMargin
            titleView.right == view.rightMargin
            titleView.height == 20
        }
        
        constrain(logTableView, titleView, view) { logTableView, titleView, view in
            logTableView.top == titleView.bottom + 15
            logTableView.left == view.leftMargin
            logTableView.right == view .rightMargin
            logTableView.bottom == view.bottomMargin
        }
        
        constrain(newLogButton, view) { newLogButton, view in
            newLogButton.bottom == view.bottomMargin - 10
            newLogButton.right == view.rightMargin - 10
            newLogButton.height == 50
            newLogButton.width == 50
        }
        
        constrain(settingsButton, view) { settingsButton, view in
            settingsButton.left == view.leftMargin + 10
            settingsButton.bottom == view.bottomMargin - 10
            settingsButton.height == 50
            settingsButton.width == 50
        }
    }
}

extension LogListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { action, indexPath in
            store.dispatch(DeleteLogAction(log: store.state.logState.logs[indexPath.row]))
        }
        
        return [deleteAction]
    }

}
