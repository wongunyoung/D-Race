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
    
    //Return current date in the format "Month Day, Year"
    func getCurDate() -> String{
        //Get current date(non-formatted)
        let dateS = Date().addingTimeInterval(24*60)
        
        //Define date format
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        //Formatting the date
        let date = dateFormatter.string(from: dateS)
        
        return date
    }
    
    //Save exercise time from user input to the FireBase database
    func saveExercise(exerciseMin:Int, userID:String){
        let curDate = getCurDate()
        
        userRef.observeSingleEvent(of: .value, with: { (DataSnapshot) in
            //If the record of today dosen't exist, make new one
            if DataSnapshot.hasChild("exerciseList") == false
                || DataSnapshot.childSnapshot(forPath: "exerciseList").hasChild(curDate) == false {
                self.userRef.child("exerciseList").child(curDate).setValue(exerciseMin)
                self.userRef.child("totalExercise").setValue(exerciseMin)
                
                //get group number
                let group = DataSnapshot.childSnapshot(forPath: "group/").value
                print(group as! Int)
                Database.database().reference().observeSingleEvent(of: .value, with: { (DataSnapshot) in
                    if DataSnapshot.hasChild("ranking"){
                        Database.database().reference().child("ranking").child("\(group as! Int)").child(userID).setValue(exerciseMin)
                    }
                    else{
                        Database.database().reference().child("ranking").child("\(group as! Int)").child(userID).setValue(exerciseMin)
                    }
                })
                
                
            }
            else{   //If the record exists, add new value to it
                let curExercise = DataSnapshot.childSnapshot(forPath: "exerciseList/" + curDate).value
                let newExercise = (curExercise as! Int) + exerciseMin
                
                let curTotalExercise = DataSnapshot.childSnapshot(forPath: "totalExercise/").value
                let newTotalExercise = (curTotalExercise as! Int) + exerciseMin
                
                self.userRef.child("exerciseList").child(curDate).setValue(newExercise)
                self.userRef.child("totalExercise").setValue(newTotalExercise)
                
                //get group number
                let group = DataSnapshot.childSnapshot(forPath: "group/").value
                print(group as! Int)
                Database.database().reference().observeSingleEvent(of: .value, with: { (DataSnapshot) in
                    if DataSnapshot.hasChild("ranking"){
                        Database.database().reference().child("ranking").child("\(group as! Int)").child(userID).setValue(newTotalExercise)
                    }
                    else{
                        Database.database().reference().child("\(group as! Int)").child(userID).setValue(newTotalExercise)
                    }
                })
            }
            
            self.userRef.child("currentUpdate").setValue(curDate)
        })
        
    }
    
    func saveWeight(weight:String){
        let curDate = getCurDate()
        self.userRef.child("weightList").child(curDate).setValue(weight)
        self.userRef.child("lastWeight").setValue(weight)
    }
    
    func saveStartingWeight(weight:String){
        self.userRef.child("startingWeight").setValue(weight)
        
        if let dWeight = Double(weight) {
            for i in 1...15 {
                if dWeight >= Double(i-1) * 10.0 && dWeight < Double(i) * 10.0 {
                    self.userRef.child("group").setValue(i)
                }
            }
        }
    }
}
