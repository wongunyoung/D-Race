//
//  DataController.swift
//  DRace
//
//  Created by sgcs on 2017. 11. 9..
//  Copyright © 2017년 sgcs. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class RecordViewController: UIViewController {
    
    @IBOutlet weak var exerciseValue: UILabel!
    
    @IBOutlet weak var weightValue: UILabel!
    @IBOutlet weak var startingWeightValue: UILabel!
    
    let userRef = Database.database().reference().child((Auth.auth().currentUser?.uid)!)
    
    override func viewDidLoad() {
        let date = CustomDateFormatter.getCurDate()
        userRef.observe(.value, with: { (DataSnapshot) in
            
            //Part for exercise data
            if DataSnapshot.hasChild("exerciseList") == false || DataSnapshot.childSnapshot(forPath: "exerciseList").hasChild(date) == false{
                //If there is not exercise data for today
                self.exerciseValue.text = "미등록"
            }
            else{
                //If there is exercise data for today
                
                //Calculate hout/minute
                var minute = DataSnapshot.childSnapshot(forPath: "exerciseList").childSnapshot(forPath: date).value as! Int
                let hour = minute / 60
                minute = minute % 60
                
                //Text formatting
                var labelText = ""
                if hour != 0{
                    labelText += "\(hour)시간"
                }
                if minute != 0{
                    if !labelText.isEmpty{
                        labelText += " "
                    }
                    labelText += "\(minute)분"
                }
                
                self.exerciseValue.text = labelText
            }
            
            //Part for weight data
            if let weightText = DataSnapshot.childSnapshot(forPath: "lastWeight").value{
                self.weightValue.text = weightText as! String + " kg"
            }
            
            //Part for starting weight data
            if let startingWeightText = DataSnapshot.childSnapshot(forPath: "startingWeight").value{
                self.startingWeightValue.text = startingWeightText as! String + " kg"
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

