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
        
        //Save data to firebase database
        
        ref = Database.database().reference()
        if weight.text != "" {
            if user != nil {
                //move user to the home screen
                ref = Database.database().reference()
                ref?.child("\(user?.uid)").child("weightList").childByAutoId().setValue((self.weight?.text)!)
                
                ref?.child("\(user?.uid)").observeSingleEvent(of: .value, with: { (DataSnapshot) in
                    if DataSnapshot.hasChild("startingWeight") == false {
                        // the user uses the app fo the first time; starting weight variable must be created in firebase database
                        ref?.child("\(self.user?.uid)").child("startingWeight").setValue((self.weight?.text)!)
                    }
                    else{
                        //reinitialize starting weignt; means that another game started
                        
                        //TODO:
                        
                        
                        
                        print("hello")
                    }
                })
            } else {
                    // No user is signed in.
                    print("Error")
                    
                }
            }
        }

    @IBAction func exerciseSubmit(_ sender: Any) {
        
        ref = Database.database().reference()
        if exercise.text != "" {
            
            Auth.auth().addStateDidChangeListener { (auth, user) in
                if user != nil {
                    //move user to the home screen
                    ref = Database.database().reference()
                    ref?.child("\(user?.uid)").child("exerciseList").childByAutoId().setValue((self.exercise?.text)!)
                    
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
