//
//  DataController.swift
//  DRace
//
//  Created by sgcs on 2017. 11. 9..
//  Copyright © 2017년 sgcs. All rights reserved.
//

import Foundation
import UIKit

class DataController: UIViewController {
    
    @IBOutlet weak var exerdata: UITextView!
    @IBOutlet weak var weightdata: UITextView!
    
    override func viewDidLoad() {
        exerdata.text = "오늘의 운동량은 10km입니다."
        exerdata.backgroundColor = UIColor(red: 255, green: 195, blue: 190, alpha: 1)
        weightdata.text = "현재 몸무게 10kg입니다."
        weightdata.backgroundColor = UIColor(red: 255, green: 195, blue: 190, alpha: 1)
    }
    
}

