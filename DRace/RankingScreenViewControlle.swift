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


class RankingScreenViewController: UITableViewController{
    
    var userExerciseRanking: [String: Int] = [:]
    var sortedExerciseTime:[String] = []
    
    /*
    let exerciseRankingRef = Database.database().reference().child("exerciseRanking")
    let lossRankingRef = Database.database().reference().child("lossWeightRanking")
    let userRef = Database.database().reference().child((Auth.auth().currentUser?.uid)!)
    */
 
    var group = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userRef?.observeSingleEvent(of: .value, with: { (DataSnapshot) in
            self.group = DataSnapshot.childSnapshot(forPath: "group").value as! Int
            self.getRankingData()
        })
    }
    
    /*
    var curHandle:UInt = 0
    var handleAssigned = false
    */
    
    var userIdx = -1
    func getRankingData(){
        /*if handleAssigned{
            exerciseRankRef?.child("\(self.group)").removeObserver(withHandle: curHandle)
        }
        else{
            handleAssigned = true
        }*/

        exerciseRankRef?.child("\(self.group)").observe(.value) { (DataSnapshot) in
            let exerciseRankingQuery = exerciseRankRef?.child("\(self.group)").queryOrderedByValue()
            exerciseRankingQuery?.observeSingleEvent(of:.value, with:{ (DataSnapshot) in
                self.sortedExerciseTime.removeAll()
                
                var idx = 0
                for child in DataSnapshot.children.reversed(){
                    let childString = "\(child)"
                    let childComponent = childString.components(separatedBy: " ")
                    self.sortedExerciseTime.append(childComponent[2])
                    
                    if childComponent[1].components(separatedBy: CharacterSet(charactersIn: "()"))[1] == userID{
                        self.userIdx = idx
                    }
                    idx += 1
                }
                self.tableView.reloadData()
            })
        }
        
        /*print(newHandle!)
        curHandle = newHandle!*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedExerciseTime.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingItem", for: indexPath) as! RankingItem
        
        cell.rankLabel?.text = "\(indexPath.row + 1)위"
        cell.valueLabel?.text = CustomTimeFormatter.time(rawMinuteS: sortedExerciseTime[indexPath.row])
        if (userIdx == indexPath.row){
            cell.messageLabel?.text = "당신의 순위입니다!"
        }
        else{
            cell.messageLabel?.text = ""
        }
        
        return cell
    }

}

class RankingItem:UITableViewCell{
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
}


