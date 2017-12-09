//
//  RankingDataModel.swift
//  DRace
//
//  Created by 최광익 on 2017. 12. 8..
//  Copyright © 2017년 Jayron Cena. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class RankingDataModel{
    var sortedExerciseTime:[String] = []
    weak var rankingDelegate:()->Void?
    
    let exerciseRankingRef = Database.database().reference().child("exerciseRanking")
    let lossRankingRef = Database.database().reference().child("lossWeightRanking")
    let userRef = Database.database().reference().child((Auth.auth().currentUser?.uid)!)
    
    var group = 0
    
    init(){
        self.userRef.observe(.value) { (DataSnapshot) in
            self.group = DataSnapshot.childSnapshot(forPath: "group").value as! Int
            self.getRankingData()
        }
    }
    
    var curHandle:UInt = 0
    var handleAssigned = false
    
    func getRankingData(){
        if handleAssigned{
            exerciseRankingRef.removeObserver(withHandle: curHandle)
        }
        else{
            handleAssigned = true
        }
        
        let newHandle = exerciseRankingRef.observe(.value) { (DataSnapshot) in
            let exerciseRankingQuery = self.exerciseRankingRef.child("\(self.group)").queryOrderedByValue()
            exerciseRankingQuery.observeSingleEvent(of: .value, with: { (DataSnapshot) in
                self.sortedExerciseTime.removeAll()
                for child in DataSnapshot.children.reversed(){
                    let childString = "\(child)"
                    let childComponent = childString.components(separatedBy: " ")
                    self.sortedExerciseTime.append(childComponent[2])
                }
            })
        }
        
        //print(newHandle)
        curHandle = newHandle
    }
}
