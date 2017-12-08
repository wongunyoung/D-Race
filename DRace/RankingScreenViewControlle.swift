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

var userExerciseRanking = [Dictionary<String, Int>]()

class RankingScreenViewController: UITableViewController {
    
    
    let user = Auth.auth().currentUser
    let rankingRef = Database.database().reference().child("exerciseRanking")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getExerciseRanking()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        getExerciseRanking()
    }
    
    func getExerciseRanking(){
        
        Database.database().reference().child((self.user?.uid)!).observeSingleEvent(of: .value, with: { (DataSnapshot) in
            if DataSnapshot.hasChild("group") == true{
                
                //get group number
                let group = DataSnapshot.childSnapshot(forPath: "group/").value
                
                self.rankingRef.child("\(group as! Int)").observeSingleEvent(of: .value, with: { (DataSnapshot) in
                    for child in DataSnapshot.children{
                        
                        let snap = child as! DataSnapshot
                        let key = snap.key
                        let value = snap.value
                        let exerciseOfUsers = [key : value as! Int]
                        userExerciseRanking.append(exerciseOfUsers)
                    }
                    
                    self.SortArrayDictionary(parameter: userExerciseRanking)
                })
                
            }
            else{
                print("Cannot Get Exercise Time ranking. No exercise time data.The user inputted an exercise time")
            }
            
        })
    }
    
    func SortArrayDictionary(parameter: [Dictionary<String, Int>]){
        
        // sort an array of dictionaries
        
        print(parameter)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingItem", for: indexPath)

        let label = cell.viewWithTag(1000) as! UILabel
        let rankingLabel = cell.viewWithTag(100) as! UILabel
        
        rankingLabel.text = "\(indexPath.row + 1)"
        
        if indexPath.row % 5 == 0 {
            label.text = "Jayron Cena"
        }else if indexPath.row % 5 == 1{
            label.text = "Choi GwangIk"
        }else if indexPath.row % 5 == 2{
            label.text = "Won GonYeong"
        }else if indexPath.row % 5 == 3{
            label.text = "Angelina Jolie"
        }else if indexPath.row % 5 == 4{
            label.text = "Brad Pitt"
        }
        return cell
        
    }
    
    func configureText(for cell: UITableViewCell, with item: RankingItem){
        
        let labelName = cell.viewWithTag(1000) as! UILabel
        labelName.text = item.text
    }


}

