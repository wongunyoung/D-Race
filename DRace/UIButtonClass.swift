//
//  UIButtonClass.swift
//  DRace
//
//  Created by sgcs on 2017. 11. 15..
//  Copyright © 2017년 sgcs. All rights reserved.
//

import Foundation
import UIKit

class UIRoundButton:UIButton{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5.0
        self.backgroundColor = UIColor(red: 255, green: 195, blue: 190, alpha:1)
    }
}
