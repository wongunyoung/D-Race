//
//  AuthViewController.swift
//  DRace
//
//  Created by wonjongpill on 2017. 11. 18..
//  Copyright © 2017년 Jayron Cena. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FacebookLogin
import GoogleSignIn

var ref:DatabaseReference?
var handle:DatabaseHandle?

class AuthViewController: UIViewController, LoginButtonDelegate, GIDSignInUIDelegate{
    @IBOutlet weak var activityLoadingSpin: UIActivityIndicatorView!
    //se to delegates LoginButtonDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                //move user to the home screen
                
                let mainStoryboard: UIStoryboard =  UIStoryboard(name:"Main", bundle:nil)
                let homeViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeView")
                
                self.present(homeViewController, animated: true, completion: nil)
                
            } else {
                //FaceBook Signin
                let FBloginButton = LoginButton(readPermissions: [ .publicProfile ])
                FBloginButton.center = self.view.center
                FBloginButton.delegate = self;
                
                self.view.addSubview(FBloginButton)
                
                //Google Signin
                GIDSignIn.sharedInstance().uiDelegate = self
                //GIDSignIn.sharedInstance().signIn()
                
                let GGloginButton = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
                GGloginButton.center = self.view.center
                GGloginButton.center.y +=  50.0
                
                self.view.addSubview(GGloginButton)
            }
        }
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .failed(let error):
            print(error)
        case .cancelled:
            print("Cancelled")
        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
            print("Logged In")
            
            print("grantedPermissions = \(grantedPermissions), declinedPermissions = \(declinedPermissions), accessToken = \(accessToken)")
            print("FaceBook user ID = " + accessToken.userId!)
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    print(error)
                }
                else{
                    print("FireBase FaceBook Login Success")
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("FaceBook log out")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
