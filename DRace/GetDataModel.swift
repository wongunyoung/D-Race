//
//  GetDataModel.swift
//  DRace
//
//  Created by 최광익 on 2017. 12. 4..
//  Copyright © 2017년 Jayron Cena. All rights reserved.
//

import Foundation
import FirebaseDatabase

class GetDataModel {
    let uid:String
    let userRef:DatabaseReference

    init(_uid:String){
        uid = _uid
        userRef = Database.database().reference().child(_uid)
    }
    
    func isUserRegistered() -> Bool{
        var ret = false
        
        Database.database().reference().observeSingleEvent(of: .value, with: { (DataSnapshot) in
            if (DataSnapshot.hasChild(self.uid)){
                ret = true
            }
        }){ (error) in
            print(error.localizedDescription)
        }
        
        return ret
    }
}
