//
//  FullListTableViewController.swift
//  6WeekChallenge
//
//  Created by Isidore Baldado on 2/23/18.
//  Copyright © 2018 Isidore Baldado. All rights reserved.
//

import UIKit

class FullListTableViewController: UITableViewController, PersonControllerDelegate {
    
    // Life Cycle
    override func viewDidLoad() {
        PersonController.shared.delegate = self
    }
    
    // PersonControllerDelegate
    func personControllerDidUpdate() {
        tableView.reloadData()
    }
    
    // Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        present(addPersonAlertController, animated: true)
    }

    // TableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = PersonController.shared.persons[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            PersonController.shared.deletePerson(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Alert Controller for Adding Person
    var addPersonAlertController: UIAlertController {
        let alertController = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        var textField: UITextField!
        alertController.addTextField {
            textField = $0
            $0.placeholder = "Name..."
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let text = textField.text else{
                return
            }
            
            guard !text.isEmpty, text != "" else{
                textField.placeholder = "Please type a name"
                self?.present(self?.noNameAlertController ?? UIAlertController(), animated: true)
                return
            }
            
            PersonController.shared.addPerson(withName: text)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    // Alert Controller for Entering an Empty Name
    var noNameAlertController: UIAlertController {
        let alertController = UIAlertController(title: "No name", message: "You did not type in a name", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "My bad, let my try again", style: .default) { [weak self] _ in
            self?.present(self?.addPersonAlertController ?? UIAlertController(), animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Nevermind", style: .cancel)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }

}
