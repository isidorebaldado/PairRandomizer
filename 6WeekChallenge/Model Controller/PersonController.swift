//
//  PersonController.swift
//  6WeekChallenge
//
//  Created by Isidore Baldado on 2/23/18.
//  Copyright © 2018 Isidore Baldado. All rights reserved.
//

import Foundation

protocol PersonControllerDelegate{
    func personControllerDidUpdate()
}

class PersonController {
    
    static let shared = PersonController()
    var delegate: PersonControllerDelegate?
    var persons = [Person]()
    var saveFile = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask).first!
        .appendingPathComponent("persons")
        .appendingPathExtension("plist")
    
    init() {
        loadFromPersistance()
    }
    
    //CRUD
    func addPerson(withName name: String){
        persons.append(name)
        delegate?.personControllerDidUpdate()
        saveToPersistance()
    }
    
    func delete(_ person: Person){
        guard let index = persons.index(of: person) else {return}
        persons.remove(at: index)
        //delegate?.personControllerDidUpdate() // messes with tableView deletion
        saveToPersistance()
    }
    
    func deletePerson(at index: Int){
        persons.remove(at: index)
        //delegate?.personControllerDidUpdate() // messes with tableView deletion
        saveToPersistance()
    }
    
    // Persistance
    func saveToPersistance(){
        do {
            try PropertyListEncoder().encode(persons).write(to: saveFile)
        }catch {
            print("Error encoding data: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistance(){
        do {
            persons = try PropertyListDecoder().decode([Person].self, from: Data(contentsOf: saveFile))
        }catch {
            print("Error decoding data: \(error.localizedDescription)")
        }
    }
    
    // Randomizing
    func randomize() -> [Person]{
        var copy = persons
        for _ in 1...100{
            let random1 = Int(arc4random()) % copy.count
            let random2 = Int(arc4random()) % copy.count
            copy.insert(copy.remove(at: random1), at: random2)
        }
        return copy
    }
    
    
}
