//
//  NewLogEntryType.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/13/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import UIKit
import Cartography
import RxSwift
import RxCocoa

class NewLogEntryTypeViewController: UIViewController {
    let createButton = UIButton()
    let cancelButton = UIButton()
    let titleLabel = UILabel()
    let nameTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        createButton.addTarget(self, action: #selector(self.createTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(self.cancelTapped), for: .touchUpInside)
    }
    
    @objc func createTapped() {
        if let name = nameTextField.text {
            let newEntryType = LogEntryType()
            newEntryType.name = name
            store.dispatch(CreateNewLogEntryTypeAction(logEntryType: newEntryType))
            store.dispatch(RoutingAction(destination: .settings))
        }
    }
    
    @objc func cancelTapped() {
        store.dispatch(RoutingAction(destination: .settings))
    }
}

// MARK: - View Configuration
private extension NewLogEntryTypeViewController {
    func configureViews() {
        // View Hierarchy
        view.addSubview(titleLabel)
        view.addSubview(nameTextField)
        view.addSubview(createButton)
        view.addSubview(cancelButton)
        
        // Style
        view.backgroundColor = Theme.viewBackgroundColor
        titleLabel.text = "New Entry Type"
        titleLabel.textAlignment = .center
        nameTextField.borderStyle = .roundedRect
        nameTextField.placeholder = "Enter Log Entry Type"
        nameTextField.backgroundColor = UIColor.white
        createButton.setTitle("Create", for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        
        // Layout
        constrain(titleLabel, view) { titleLabel, view in
            titleLabel.centerX == view.centerX
            titleLabel.top == view.topMargin
            titleLabel.width == 200
            titleLabel.height == 50
        }
        
        constrain(nameTextField, titleLabel, view) { nameTextField, titleLabel, view in
            nameTextField.top == titleLabel.bottom + 50
            nameTextField.left == view.leftMargin
            nameTextField.right == view.rightMargin
            nameTextField.height == 50
        }
        
        constrain(cancelButton, createButton) { cancelButton, createButton in
            cancelButton.top == createButton.bottom + 15
            cancelButton.width == 100
            cancelButton.height == 50
        }
        
        constrain(createButton, nameTextField) { createButton, nameTextField in
            createButton.top == nameTextField.bottom + 20
            createButton.width == 100
            createButton.height == 50
        }

    }
}


