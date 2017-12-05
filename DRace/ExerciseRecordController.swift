//
//  ExerciseController.swift
//  DRace
//
//  Created by sgcs on 2017. 11. 9..
//  Copyright © 2017년 sgcs. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

var exerciseList = [String]()

class ExcerciseRecordController: UITableViewController {
    
    let user = Auth.auth().currentUser

    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseList.removeAll()
        
        //sync with database
        
        ref = Database.database().reference()
        
        handle = ref?.child("\(user?.uid)").child("exerciseList").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? String? {
                exerciseList.append(item!)
                self.tableView.reloadData()
                ref?.keepSynced(true)
            }
        })
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)
        
        var todo : String = exerciseList[indexPath.row]
        
        cell.textLabel?.text = todo
        
        return cell
    }
    
    
}
