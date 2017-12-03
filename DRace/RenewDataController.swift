//
//  RenewDataController.swift
//  DRace
//
//  Created by Jayron Cena on 2017. 11. 22..
//  Copyright © 2017년 Jayron Cena. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class RenewDataController: UIViewController {

    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var exercisePicker: UIDatePicker!
    
    let user = Auth.auth().currentUser
    var renewDataModel:RenewDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Data renewing model
        renewDataModel = RenewDataModel(uid: (user?.uid)!)
        
        //UI initialization
        exercisePicker.countDownDuration = 0.0
    }
    
    @IBAction func weightSubmit(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let dateS = Date().addingTimeInterval(24*60)
        
        // US English Locale (en_US)
        dateFormatter.locale = Locale(identifier: "en_US")
        var date = dateFormatter.string(from: dateS)
        
        
        //Save data to firebase database
        
        ref = Database.database().reference()
        if weight.text != "" {
            if user != nil {

                ref = Database.database().reference()
                ref?.child("\(user?.uid)").child("weightList").child("\(date)").setValue((self.weight?.text)!)
                
                
                //save the starting weight to firebase database
                //must be initialize by the timer
                ref?.child("\(user?.uid)").observeSingleEvent(of: .value, with: { (DataSnapshot) in
                    if DataSnapshot.hasChild("startingWeight") == false {
                        
                        // the user uses the app fo the first time; starting weight variable must be created in firebase database
                        ref?.child("\(self.user?.uid)").child("startingWeight").setValue((self.weight?.text)!)
                    }
                    else{
                        //TODO:
                        //when the timer restarts new game
                        //reinitialize starting weignt; means that another new game started

                    }
                })
            } else {
                    // No user is signed in.
                    print("Error")
                    
                }
            }
        }

    @IBAction func exerciseSubmit(_ sender: Any) {
        let newExerciseVal = Int(exercisePicker.countDownDuration / 60)
        renewDataModel?.saveExercise(exerciseMin: newExerciseVal)
        //print(newExerciseVal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
