//
//  LogEditorViewController.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/8/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import UIKit
import MapKit
import Cartography
import RealmSwift

class LogEditorViewController: UIViewController {
    let doneButton = UIButton()
    let logTitle = UILabel()
    let mapView = MKMapView()
    var entryTypeCollection: UICollectionView!
    let logEntryTable = UITableView()
    
    var entryListNotificationToken: NotificationToken? = nil
    
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

        doneButton.addTarget(self, action: #selector(self.doneTapped), for: .touchUpInside)
        
        entryTypeCollection = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        entryTypeCollection.delegate = self
        entryTypeCollection.dataSource = self
        entryTypeCollection.register(LogEntryTypeCollectionViewCell.self, forCellWithReuseIdentifier: "entryTypeSelectionCell")
        
        logEntryTable.dataSource = self
        logEntryTable.delegate = self
        entryListNotificationToken = log.entries.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.logEntryTable else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
        
        configureViews()
    }
    
    deinit {
        entryListNotificationToken?.invalidate()
    }
    
    @objc func doneTapped() {
        store.dispatch(RoutingAction(destination: .logList))
    }
}

// MARK: - View Configuration
private extension LogEditorViewController {
    func configureViews() {
        // View Hierarchy
        view.addSubview(logTitle)
        view.addSubview(doneButton)
        view.addSubview(mapView)
        view.addSubview(entryTypeCollection)
        view.addSubview(logEntryTable)
        
        // Style
        view.backgroundColor = Theme.viewBackgroundColor
        logTitle.text = log?.name
        logTitle.textAlignment = .center
        doneButton.setTitle("Done", for: .normal)
        entryTypeCollection.backgroundColor = .clear
        
        // Layout
        constrain(logTitle, view) { logTitle, view in
            logTitle.centerX == view.centerX
            logTitle.top == view.topMargin
            logTitle.left == view.leftMargin
            logTitle.right == view.rightMargin
        }
        constrain(doneButton, view) { doneButton, view in
            doneButton.top == view.topMargin
            doneButton.left == view.leftMargin
        }
        
        constrain(mapView, logTitle, view) { mapView, logTitle, view in
            mapView.top == logTitle.bottom + 15
            mapView.left == view.leftMargin
            mapView.right == view.rightMargin
            mapView.height == 200
        }
        
        constrain(entryTypeCollection, mapView, view) { entryTypeCollection, mapView, view in
            entryTypeCollection.top == mapView.bottom + 5
            entryTypeCollection.left == view.leftMargin
            entryTypeCollection.right == view.rightMargin
            entryTypeCollection.height == 100
        }
        
        constrain(logEntryTable, entryTypeCollection, view) { logEntryTable, entryTypeCollection, view in
            logEntryTable.top == entryTypeCollection.bottom + 5
            logEntryTable.bottom == view.bottomMargin
            logEntryTable.left == view.leftMargin
            logEntryTable.right == view.rightMargin
        }
    }
}

extension LogEditorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.state.logState.logEntryTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "entryTypeSelectionCell", for: indexPath) as! LogEntryTypeCollectionViewCell
        cell.entryTypeLabel.text = store.state.logState.logEntryTypes[indexPath.row].name
        cell.backgroundColor = .blue
        cell.entryTypeLabel.textColor = .white
        
        return cell
    }
}

extension LogEditorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let logEntryType = store.state.logState.logEntryTypes[indexPath.row]
        let width = logEntryType.name.width(withConstraintedHeight: 20, font: .systemFont(ofSize: 12.0))
        return CGSize(width: width, height: 15)
    }
}

extension LogEditorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        store.dispatch(AddLogEntryAction(log: log, logEntryType: store.state.logState.logEntryTypes[indexPath.row]))
    }
}

extension LogEditorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return log.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell") ?? UITableViewCell.init(style: .subtitle, reuseIdentifier: "entryCell")
        cell.textLabel?.text = log.entries[indexPath.row].notes
        cell.detailTextLabel?.text = log.entries[indexPath.row].time.description
        
        return cell
    }
}

extension LogEditorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { action, indexPath in
            store.dispatch(DeleteLogEntryAction(log: self.log, logEntry: self.log.entries[indexPath.row]))
        }
        
        return [deleteAction]
    }
}
