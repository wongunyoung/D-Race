//
//  ViewController.swift
//  RankingScreen
//
//  Created by Jayron Cena on 2017. 11. 15..
//  Copyright © 2017년 CodeWithJayron. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

//var userExerciseRanking = [Dictionary<String, Int>]()


class RankingScreenViewController: UITableViewController{
    
    var userExerciseRanking: [String: Int] = [:]
    var sortedExerciseTime:[(key: String, value: Int)] = []
    
    let user = Auth.auth().currentUser
    let rankingRef = Database.database().reference().child("exerciseRanking")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortedExerciseTime.removeAll()
        
        Database.database().reference().child((self.user?.uid)!).observeSingleEvent(of: .value, with: { (DataSnapshot) in
            if DataSnapshot.hasChild("group") == true{
                
                //get group number
                let group = DataSnapshot.childSnapshot(forPath: "group/").value
                
                self.rankingRef.child("\(group as! Int)").observeSingleEvent(of: .value, with: { (DataSnapshot) in
                    for child in DataSnapshot.children{
                        
                        let snap = child as! DataSnapshot
                        let key = snap.key
                        let value = snap.value
                        self.userExerciseRanking[key] = value as? Int
                    }
                    
                    // sorts exercise time data
                    for (k,v) in (Array(self.userExerciseRanking).sorted {$0.1 > $1.1}) {
                        self.sortedExerciseTime.append((key: k, value: v))
                    }
                    self.tableView.reloadData()
                    
                })
                
            }
            else{
                print("Cannot Get Exercise Time ranking. No exercise time data.The user inputted an exercise time")
            }
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingItem", for: indexPath)
        
        //cell.textLabel?.text = "\(sortedExerciseTime[indexPath.row].key) + \(sortedExerciseTime[indexPath.row].value)"
        
        return cell
    }

}

