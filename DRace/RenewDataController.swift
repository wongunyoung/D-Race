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

class RenewDataController: CustomTextFieldDelegate{
    
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var exercisePicker: UIDatePicker!
    
    @IBOutlet weak var backgroundButton: UIButton!
    //exercise pop up view
    @IBOutlet weak var centerPopupContraint: NSLayoutConstraint!
    @IBOutlet weak var exercisePopupView: UIView!
    
    //weight pop up view
    @IBOutlet weak var weightCenterPopupConstraint: NSLayoutConstraint!
    @IBOutlet weak var weightPopupView: UIView!
    
    let user = Auth.auth().currentUser
    var renewDataModel:RenewDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make the corner of the popup view round
        exercisePopupView.layer.cornerRadius = 10
        exercisePopupView.layer.masksToBounds = true
        weightPopupView.layer.cornerRadius = 10
        weightPopupView.layer.masksToBounds = true
        
        //Data renewing model
        renewDataModel = RenewDataModel(uid: (user?.uid)!)
        
        //UI initialization
        exercisePicker.countDownDuration = 0.0
        
        //Set delegate
        weight.delegate = self
        //Set keyboard to decimal pad to only allow 0123456789. characters
        weight.keyboardType = .decimalPad
    }
    
    @IBAction func showExercisePopup(_ sender: Any) {
        
        //make sure that weight popup is closed
        weightCenterPopupConstraint.constant = -360
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        
        centerPopupContraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        self.backgroundButton.alpha = 0.8
    }
    
    @IBAction func showWeightPopup(_ sender: Any) {
        
        //make sure that exercise popup is closed
        centerPopupContraint.constant = -360
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        
        weightCenterPopupConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        self.backgroundButton.alpha = 0.8
    }
    @IBAction func closeExercisePopup(_ sender: Any) {
        centerPopupContraint.constant = -360
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        self.backgroundButton.alpha = 0
    }
    
    @IBAction func closeWeightPopup(_ sender: Any) {
        weightCenterPopupConstraint.constant = -360
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        
        self.backgroundButton.alpha = 0
    }
    
    @IBAction func closeAllPopup(_ sender: Any) {
        
        centerPopupContraint.constant = -360
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        
        weightCenterPopupConstraint.constant = -360
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        
        self.backgroundButton.alpha = 0
    }
    
    @IBAction func weightSubmit(_ sender: Any) {
        if let newWeightVal = weight.text {
            renewDataModel?.saveWeight(weight: newWeightVal)
        }
        
        //remove pop up after saving
        weightCenterPopupConstraint.constant = -360
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        self.backgroundButton.alpha = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        weight.endEditing(true)
    }
    
    @IBAction func exerciseSubmit(_ sender: Any) {
        let newExerciseVal = Int(exercisePicker.countDownDuration / 60)
        renewDataModel?.saveExercise(exerciseMin: newExerciseVal)
        //print(newExerciseVal)
        
        //remove popup after saving
        centerPopupContraint.constant = -360
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        self.backgroundButton.alpha = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

