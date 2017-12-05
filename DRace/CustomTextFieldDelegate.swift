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
                let  char = string.cString(using: String.Encoding.utf8)!
                let isBackSpace = strcmp(char, "\\b")
        
                let countdots =  (textField.text?.components(separatedBy: (".")).count)! - 1
                let text = textField.text!
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
                    if(text[text.index(before: text.endIndex)] != "." && isBackSpace != -92){
                        return false
                    }
                    else{
                        return true
                    }
                }
            default:
                return true
            }
        }
        
        return true
    }
}
