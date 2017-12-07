//
//  RenewDataModel.swift
//  DRace
//
//  Created by 최광익 on 2017. 12. 3..
//  Copyright © 2017년 Jayron Cena. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class RenewDataModel {
    let userRef:DatabaseReference
    
    init(uid:String){
        userRef = Database.database().reference().child(uid)
    }
    
    //Save exercise time from user input to the FireBase database
    func saveExercise(exerciseMin:Int, userID:String){
        let curDate = CustomDateFormatter.getCurDate()
        
        userRef.observeSingleEvent(of: .value, with: { (DataSnapshot) in
            //If the record of today dosen't exist, make new one
            if DataSnapshot.hasChild("exerciseList") == false
                || DataSnapshot.childSnapshot(forPath: "exerciseList").hasChild(curDate) == false {
                self.userRef.child("exerciseList").child(curDate).setValue(exerciseMin)
                //self.userRef.child("totalExercise").setValue(exerciseMin)
                
                //Get group number
                let group = DataSnapshot.childSnapshot(forPath: "group").value
                //print(group as! Int)
                Database.database().reference().child("ranking").child("\(group as! Int)").child(userID).setValue(exerciseMin)
            }
            else{   //If the record exists, add new value to it
                //Get current exercising time, and add new one to that
                let curExercise = DataSnapshot.childSnapshot(forPath: "exerciseList/" + curDate).value
                let newExercise = (curExercise as! Int) + exerciseMin
                
                //let curTotalExercise = DataSnapshot.childSnapshot(forPath: "totalExercise/").value
                //let newTotalExercise = (curTotalExercise as! Int) + exerciseMin
                
                //Save new exercising time
                self.userRef.child("exerciseList").child(curDate).setValue(newExercise)
                //self.userRef.child("totalExercise").setValue(newTotalExercise)
                
                //Get group number
                let group = DataSnapshot.childSnapshot(forPath: "group").value
                //print(group as! Int)
                Database.database().reference().child("ranking").child("\(group as! Int)").child(userID).setValue(newExercise)
            }
            
            self.userRef.child("currentUpdate").setValue(curDate)
        })
        
    }
    
    func saveWeight(weight:String){
        //Set weight value
        self.userRef.child("lastWeight").setValue(weight)
        
        userRef.observeSingleEvent(of: .value, with: { (DataSnapshot) in
            //Set lose weight value
            let sWeight = DataSnapshot.childSnapshot(forPath: "startingWeight").value as! NSString
            let lossWeight = sWeight.floatValue - (weight as NSString).floatValue
            let month = CustomDateFormatter.getCurMonth()
            self.userRef.child("lossWeight/" + month).setValue(lossWeight)
        })
    }
    
    func saveStartingWeight(weight:String){
        self.userRef.child("startingWeight").setValue(weight)
        self.userRef.child("lastWeight").setValue(weight)
        
        if let dWeight = Double(weight) {
            for i in 1...15 {
                if dWeight >= Double(i-1) * 10.0 && dWeight < Double(i) * 10.0 {
                    self.userRef.child("group").setValue(i)
                }
            }
        }
    }
}
