//
//  RandomizeTableViewController.swift
//  6WeekChallenge
//
//  Created by Isidore Baldado on 2/23/18.
//  Copyright © 2018 Isidore Baldado. All rights reserved.
//

import UIKit

class RandomizeTableViewController: UITableViewController {
    
    var tableData = [Person]()
    
    // Randomize on Shake
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            tableData = PersonController.shared.randomize()
            tableView.reloadData()
        }
    }

    // TableView Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Int(ceil(Double(tableData.count) / 2))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == tableView.numberOfSections - 1, tableData.count % 2 != 0 {return 1}
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row + indexPath.section*2]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group: \(section + 1)"
    }
 
}
