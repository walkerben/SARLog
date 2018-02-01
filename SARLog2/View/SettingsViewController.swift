//
//  SettingsViewController.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/8/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import UIKit
import Cartography

class SettingsViewController: UIViewController {
    let doneButton = UIButton()
    let titleLabel = UILabel()
    let addButton = UIButton(type: .roundedRect)
    let entryTypeTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        doneButton.addTarget(self, action: #selector(self.doneTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(self.addTapped), for: .touchUpInside)
        
        entryTypeTableView.dataSource = self
    }
    
    @objc func doneTapped() {
        store.dispatch(RoutingAction(destination: .logList))
    }
    
    @objc func addTapped() {
        store.dispatch(RoutingAction(destination: .newLogEntryType))
    }
}

// MARK: - View Configuration
private extension SettingsViewController {
    func configureViews() {
        // View Hierarchy
        view.addSubview(titleLabel)
        view.addSubview(entryTypeTableView)
        view.addSubview(doneButton)
        view.addSubview(addButton)
        
        
        // Style
        titleLabel.text = "Settings"
        titleLabel.textAlignment = .center
        view.backgroundColor = Theme.viewBackgroundColor
        doneButton.setTitle("<", for: .normal)
        
        addButton.backgroundColor = UIColor.green
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.layer.cornerRadius = 25
        addButton.layer.shadowColor = UIColor.gray.cgColor
        addButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        entryTypeTableView.backgroundColor = UIColor.white
        entryTypeTableView.alpha = 0.9
        entryTypeTableView.allowsSelection = false
        
        // Layout
        constrain(titleLabel, view) { titleLabel, view in
            titleLabel.top == view.topMargin
            titleLabel.left == view.leftMargin
            titleLabel.right == view.rightMargin
        }

        constrain(doneButton, view) { doneButton, view in
            doneButton.top == view.topMargin
            doneButton.left == view.leftMargin
        }
        
        constrain(addButton, view) { addButton, view in
            addButton.bottom == view.bottomMargin - 10
            addButton.right == view.rightMargin - 10
            addButton.height == 50
            addButton.width == 50
        }
        
        constrain(entryTypeTableView, titleLabel, view) { entryTypeTableView, titleLabel, view in
            entryTypeTableView.top == titleLabel.bottom + 15
            entryTypeTableView.left == view.leftMargin
            entryTypeTableView.right == view .rightMargin
            entryTypeTableView.bottom == view.bottomMargin
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.state.logState.logEntryTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryTypeCell") ?? UITableViewCell.init(style: .default, reuseIdentifier: "entryTypeCell")
        cell.textLabel?.text = store.state.logState.logEntryTypes[indexPath.row].name
        
        return cell
    }
}
