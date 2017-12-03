//
//  RenewDataModel.swift
//  DRace
//
//  Created by 최광익 on 2017. 12. 3..
//  Copyright © 2017년 Jayron Cena. All rights reserved.
//

import Foundation
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
    func saveExercise(exerciseMin:Int){
        let curDate = getCurDate()
        
        userRef.observeSingleEvent(of: .value, with: { (DataSnapshot) in
            //If the record of today dosen't exist, make new one
            if DataSnapshot.hasChild("exerciseList") == false
                || DataSnapshot.childSnapshot(forPath: "exerciseList").hasChild(curDate) == false {
                self.userRef.child("exerciseList").child(curDate).setValue(exerciseMin)
            }
            else{   //If the record exists, add new value to it
                let curExercise = DataSnapshot.childSnapshot(forPath: "exerciseList/" + curDate).value
                let newExercise = (curExercise as! Int) + exerciseMin
                self.userRef.child("exerciseList").child(curDate).setValue(newExercise)
            }
            
            self.userRef.child("currentUpdate").setValue(curDate)
        })
        
    }
    
    func saveWeight(weight:String){
        
        let curDate = getCurDate()
        self.userRef.child("weightList").child(curDate).setValue(weight)
        
        userRef.observeSingleEvent(of: .value, with: { (DataSnapshot) in
            //If the record of today dosen't exist, make new one
            if DataSnapshot.hasChild("startingWeight") == false
                || DataSnapshot.childSnapshot(forPath: "startingWeight").hasChild(curDate) == false {
                self.userRef.child("startingWeight").child(curDate).setValue(weight)
            }
            else{
                //the record exist and the timer restarts (1 week had passed)
                //TODO:
                print("")
            }
            
            self.userRef.child("currentUpdate").setValue(curDate)
        })
        
    }
    
    
}
