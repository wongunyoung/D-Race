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

class RenewDataController: UIViewController , UITextFieldDelegate{

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
        
        //for UITextFieldDelegate
        weight.delegate = self
        // set keyboard to decimal pad to only allow 0123456789. characters
        weight.keyboardType = .decimalPad
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
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //setting backspace character
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        let countdots =  (textField.text?.components(separatedBy: (".")).count)! - 1
        let text = weight.text!
        let newLength = (text.count) + string.count - range.length
        
        if (countdots > 0 && string == "."){
            //test number of dots
            return false
        }
        else if(text.count == 3 && text[text.index(text.startIndex, offsetBy: 2)] != "." && isBackSpace != -92 && countdots == 0){
            textField.text?.append(".")
            return false
        }
        else if (newLength > 5){
            //test the total length of the number
            return false
        }
        else if(text.contains(".") == true){
            if(text[text.index(before: text.endIndex)] != "." && isBackSpace != -92)
            {
                return false
            }
            else{
                return true
            }
        }
        return true
        
    }

}
