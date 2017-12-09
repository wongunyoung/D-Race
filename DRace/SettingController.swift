//
//  SettingController.swift
//  DRace
//
//  Created by sgcs on 2017. 11. 14..
//  Copyright © 2017년 sgcs. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import FacebookLogin
import GoogleSignIn

class SettingController: CustomTextFieldDelegate {
    
    //각각 동일한 변수랑 연결해주면 된다.
    @IBOutlet weak var pushtime: UITextField!
    @IBOutlet weak var pushPicker: UIDatePicker!
    //push pop up view
    @IBOutlet weak var Background: UIButton!
    @IBOutlet weak var pushPopupContraint: NSLayoutConstraint!
    @IBOutlet weak var pushPopupView: UIView!
    
    //로그아웃 버튼이랑 연결
    //MARK: Actions
    @IBAction func didTapLogout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        //GIDSignIn.sharedInstance().disconnect()
        
        let mainStoryboard: UIStoryboard =  UIStoryboard(name:"Main", bundle:nil)
        let viewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "AuthViewController")
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    // 시간변경 버튼이랑 연결. 누르면 팝업창 띄워준다.
    @IBAction func showpushPopup(_ sender: Any) {
        
        //make sure that weight popup is closed
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        
        pushPopupContraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        //self.backgroundButton.alpha = 0.8
    }
    
    //Cancel 버튼이랑 연결. 적용안하고 팝 다시 뺌
    @IBAction func closetimePopup(_ sender: Any) {
        pushPopupContraint.constant = -360
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        
        self.Background.alpha = 0
    }
    
    //아무버튼이나 누르면 자동으로 popup종료. background와 연결하면 된다
    @IBAction func closeAllPopup(_ sender: Any) {
        
        pushPopupContraint.constant = -360
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        
        self.Background.alpha = 0
    }
    
    // save 버튼이랑 연결. 저장시 newtimVal에 입력값 저장하고 이걸 보내서 적용하면 된다
    @IBAction func pushtimeSubmit(_ sender: Any) {
        if let newtimeVal = pushtime.text {
            
        }
        
        //remove pop up after saving
        pushPopupContraint.constant = -360
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        self.Background.alpha = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        pushtime.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pushPopupView.layer.cornerRadius = 10
        pushPopupView.layer.masksToBounds = true
        
        //UI initialization
        pushPicker.countDownDuration = 0.0
        pushPopupContraint.constant = -360
        
        //Set delegate
        pushtime.delegate = self
        //Set keyboard to decimal pad to only allow 0123456789. characters
        pushtime.keyboardType = .decimalPad
        
    }
    
}

