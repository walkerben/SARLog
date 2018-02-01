//
//  LogViewerViewController.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/8/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import UIKit
import Cartography

class LogViewerViewController: UIViewController {
    let doneButton = UIButton()
    let logTitle = UILabel()
    
    var log: Log!
    
    init(log: Log) {
        super.init(nibName: nil, bundle: nil)
        self.log = log
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        
        doneButton.addTarget(self, action: #selector(self.doneTapped), for: .touchUpInside)
    }
    
    @objc func doneTapped() {
        store.dispatch(RoutingAction(destination: .logList))
    }
}

// MARK: - View Configuration
private extension LogViewerViewController {
    func configureViews() {
        // View Hierarchy
        view.addSubview(logTitle)
        view.addSubview(doneButton)
        
        // Style
        view.backgroundColor = Theme.viewBackgroundColor
        logTitle.text = log?.name
        logTitle.textAlignment = .center
        doneButton.setTitle("Done", for: .normal)
        
        // Layout
        constrain(logTitle, view) { logTitle, view in
            logTitle.centerX == view.centerX
            logTitle.top == view.topMargin
            logTitle.left == view.leftMargin
            logTitle.right == view.rightMargin
        }
        constrain(doneButton, view) { doneButton, view in
            doneButton.bottom == view.bottomMargin - 15
            doneButton.width == 100
            doneButton.height == 50
        }
    }
}

