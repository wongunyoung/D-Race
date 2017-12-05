//
//  GetDataModel.swift
//  DRace
//
//  Created by 최광익 on 2017. 12. 4..
//  Copyright © 2017년 Jayron Cena. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class GetDataModel {
    let uid:String
    let userRef:DatabaseReference

    init(_uid:String){
        uid = _uid
        userRef = Database.database().reference().child(_uid)
    }
    
}
