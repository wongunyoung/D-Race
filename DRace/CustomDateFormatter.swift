//
//  DateFormatter.swift
//  DRace
//
//  Created by 최광익 on 2017. 12. 7..
//  Copyright © 2017년 Jayron Cena. All rights reserved.
//

import Foundation

class CustomDateFormatter{
    //Return current date in the format "Month Day, Year"
    class func getCurDate() -> String{
        //Get current date(non-formatted)
        let dateS = Date().addingTimeInterval(24*60)
        
        //Define date format
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        //Formatting the date
        let date = dateFormatter.string(from: dateS)
        
        return date
    }
}
