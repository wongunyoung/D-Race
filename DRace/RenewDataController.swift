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
            
            Auth.auth().addStateDidChangeListener { (auth, user) in
                if user != nil {
                    //move user to the home screen
                    ref = Database.database().reference()
                    ref?.child("\(user?.uid)").child("weightList").childByAutoId().setValue((self.weight?.text)! + "kg")
                    
                } else {
                    // No user is signed in.
                    print("Error")
                    
                }
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
