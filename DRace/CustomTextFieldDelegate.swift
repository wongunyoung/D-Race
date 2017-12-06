//
//  ExerciseTextFieldDelegate.swift
//  DRace
//
//  Created by 최광익 on 2017. 12. 4..
//  Copyright © 2017년 Jayron Cena. All rights reserved.
//

import Foundation
import UIKit

class CustomTextFieldDelegate: UIViewController, UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //setting backspace character
        if let label = textField.accessibilityLabel{
            switch label {
            case "weight":
                if string == ""{
                    return true
                }
                
                if let text = textField.text{
                    var assignText = text
                    
                    let aSet = CharacterSet(charactersIn: "0123456789.").inverted
                    let compSepByCharInSet = string.components(separatedBy: aSet)
                    let numberFiltered = compSepByCharInSet.joined(separator: "")
                    
                    for char in numberFiltered{
                        if assignText.contains(".") {
                            if char != "." && assignText.last == "."{
                                assignText.append(char)
                                break
                            }
                        } else {
                            if (char == "." && !assignText.isEmpty) || (char != "." && assignText.count < 3){
                                assignText.append(char)
                            }
                        }
                    }
                    
                    textField.text = assignText
                }
                
                return false
            default:
                return true
            }
        }
        
        return true
    }
}
