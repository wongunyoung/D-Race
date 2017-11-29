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
    
    @IBOutlet weak var exercise: UITextField!
    
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let dateS = Date(timeIntervalSinceReferenceDate: 410220000)
        
        // US English Locale (en_US)
        dateFormatter.locale = Locale(identifier: "en_US")
        var date = dateFormatter.string(from: dateS)
 
        
        ref = Database.database().reference()
       
        if exercise.text != "" {
            
            Auth.auth().addStateDidChangeListener { (auth, user) in
                if user != nil {
                    //save the starting exercise to firebase database
                    ref = Database.database().reference()
                    //ref?.child("\(user?.uid)").child("exerciseList").childByAutoId().setValue(["date":"\(date)", "exercise":(self.exercise?.text)!])
                    
                    
                    ref?.child("\(user?.uid)").observeSingleEvent(of: .value, with: { (DataSnapshot) in
                        if DataSnapshot.hasChild("exerciseList") == false {
                            ref?.child("\(user?.uid)").child("exerciseList").child("\(date)").setValue((self.exercise?.text)!)
                        }
                        else{
                            
                            ref?.child("\(user?.uid)").child("exerciseList").observe(.childAdded, with: {(DataSnapshot) in
                                if let temp = DataSnapshot.key as? String{
                                    print("key is \(temp)")
                                    let tempExercise = DataSnapshot.value as! Int!
                                    print("value is \(tempExercise)")
                                    let tempNewExercise = Int((self.exercise?.text)!)
                                    print("test is \(tempNewExercise!)")
                                    
                                    let sum = (tempNewExercise!) + (tempExercise!)
                                    ref?.child("\(String(describing: user?.uid))").child("exerciseList").child("\(date)").setValue(sum)
                                    ref?.keepSynced(true)
                                }
                            })
                            
                        }
                    })
                    

                    //initialize or reinitialize the totalWeight to firebase database
                    //must be initialize by the timer
                    /*
                    ref?.child("\(user?.uid)").observeSingleEvent(of: .value, with: { (DataSnapshot) in
                        if DataSnapshot.hasChild("totalExercise") == false {
                            //TODO:
                            //make an if "statement or " when the timer restarts new game
                            // if DataSnapshot.hasChild("totalExercise") == false || timer() statement
                            
                            
                            // the user uses the app for the first time; starting weight variable must be created in firebase database
                            ref?.child("\(self.user?.uid)").child("totalExercise").setValue((self.exercise?.text)!)
                            ref?.keepSynced(true)
                        }
                    }) */
                    
                } else {
                    // No user is signed in.
                    print("Error")
                    
                }
            }
            
        }
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
