//
//  CustomTimeFormatter.swift
//  DRace
//
//  Created by 최광익 on 2017. 12. 9..
//  Copyright © 2017년 Jayron Cena. All rights reserved.
//

import Foundation

class CustomTimeFormatter{
    class func time(rawMinute:Int) -> String {
        let hour = rawMinute / 60
        let leftMinute = rawMinute % 60
        
        var formattedTime = ""
        if hour != 0{
            formattedTime += "\(hour)시간"
        }
        if leftMinute != 0{
            if !formattedTime.isEmpty{
                formattedTime += " "
            }
            formattedTime += "\(leftMinute)분"
        }
        
        let ret = formattedTime
        return ret
    }
    
    class func time(rawMinuteS:String) -> String {
        let rawMinute = (rawMinuteS as NSString).intValue
        
        let hour = rawMinute / 60
        let leftMinute = rawMinute % 60
        
        var formattedTime = ""
        if hour != 0{
            formattedTime += "\(hour)시간"
        }
        if leftMinute != 0{
            if !formattedTime.isEmpty{
                formattedTime += " "
            }
            formattedTime += "\(leftMinute)분"
        }
        
        let ret = formattedTime
        return ret
    }
}
