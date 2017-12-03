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
       let newWeightVal = weight.text
        renewDataModel?.saveWeight(weight: newWeightVal!)
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
