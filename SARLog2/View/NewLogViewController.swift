//
//  NewLogViewController.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/8/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import UIKit
import Cartography
import RxSwift
import RxCocoa

class NewLogViewController: UIViewController {
    let createButton = UIButton()
    let cancelButton = UIButton()
    let titleLabel = UILabel()
    let nameTextField = UITextField()
    let dateLabel = UILabel()
    
    let log = Log()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        createButton.addTarget(self, action: #selector(self.createTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(self.cancelTapped), for: .touchUpInside)
    }
    
    @objc func createTapped() {
        if let name = nameTextField.text {
            log.name = name
            store.dispatch(CreateNewLogAction(log: log))
            store.dispatch(RoutingAction(destination: .logEdit(log)))
        }
    }
    
    @objc func cancelTapped() {
        store.dispatch(RoutingAction(destination: .logList))
    }
}

// MARK: - View Configuration
private extension NewLogViewController {
    func configureViews() {
        // View Hierarchy
        view.addSubview(titleLabel)
        view.addSubview(nameTextField)
        view.addSubview(dateLabel)
        view.addSubview(createButton)
        view.addSubview(cancelButton)
        
        // Style
        view.backgroundColor = Theme.viewBackgroundColor
        titleLabel.text = "New Log"
        titleLabel.textAlignment = .center
        nameTextField.text = log.name
        nameTextField.borderStyle = .roundedRect
        nameTextField.placeholder = "Mission Name"
        nameTextField.backgroundColor = UIColor.white
        dateLabel.text = log.date.description
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
        
        constrain(dateLabel, nameTextField, view) { dateLabel, nameTextField, view in
            dateLabel.top == nameTextField.bottom + 15
            dateLabel.left == view.leftMargin
            dateLabel.right == view.rightMargin
            dateLabel.height == 50
        }
        
        constrain(cancelButton, createButton) { cancelButton, createButton in
            cancelButton.top == createButton.bottom + 15
            cancelButton.width == 100
            cancelButton.height == 50
        }
        
        constrain(createButton, dateLabel) { createButton, dateLabel in
            createButton.top == dateLabel.bottom + 20
            createButton.width == 100
            createButton.height == 50
        }
    }
}

