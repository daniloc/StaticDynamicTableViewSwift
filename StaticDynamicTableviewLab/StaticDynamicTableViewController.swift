//
//  StaticDynamicTableViewController.swift
//  StaticDynamicTableviewLab
//
//  Created by Danilo Campos on 5/10/19.
//  Copyright © 2019 Danilo Campos. All rights reserved.
//

import UIKit

class StaticDynamicTableViewController: UITableViewController {

    enum TableSections: Int, CaseIterable {
        case staticSection,
        dynamicSection
        
        func title() -> String {
            switch self {
            case .staticSection:
                    return "Static Cells"
            case .dynamicSection:
                    return "Dynamic Cells"
            }
        }
    }
    
    @IBOutlet var puppyCell: UITableViewCell!
    @IBOutlet var cupcakeCell: UITableViewCell!
    @IBOutlet var unicornCell: UITableViewCell!
    @IBOutlet weak var puppyLabel: UILabel!
    
    var staticCells: Array<UITableViewCell>!
    
    var dynamicContent = ["One", "Two", "Three", "Four"]
    let dynamicCellIdentifier = "Dynamic"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: dynamicCellIdentifier)
        
        staticCells = [puppyCell,
                       cupcakeCell,
                       unicornCell]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return TableSections.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == TableSections.dynamicSection.rawValue) {
            return dynamicContent.count
        } else {
            return staticCells.count
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == TableSections.staticSection.rawValue) {
            return staticCells[indexPath.row]
        } else {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: dynamicCellIdentifier, for: indexPath)

            cell.textLabel?.text = dynamicContent[indexPath.row]
            
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return TableSections(rawValue: section)!.title()
    }
    
    @IBAction func handlePuppySwitch(_ sender: UISwitch) {
        
        let updateIndexPaths = [IndexPath(row: 0, section: TableSections.dynamicSection.rawValue)]
        
        if (sender.isOn) {
            puppyLabel.text = "Puppy Enabled"

            dynamicContent.insert("Puppy is on!", at: 0)
            tableView.insertRows(at: updateIndexPaths, with: .bottom)
        } else {
            puppyLabel.text = "Puppy"
            
            dynamicContent.remove(at: 0)
            tableView.deleteRows(at: updateIndexPaths, with: .left)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (indexPath.section == TableSections.staticSection.rawValue) {
            return nil
        } else {
            return indexPath
        }
    }

}
