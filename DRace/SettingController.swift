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

class SettingController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var uiImageProfilePic: UIImageView!
    @IBOutlet weak var uiLName: UILabel!
    
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uiImageProfilePic.clipsToBounds = true
        
        
        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            let name = user.displayName
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
            
            self.uiLName.text = name
            
            //reference to firebase storage service
            let storage = Storage.storage()
            
            // Create a storage reference from our storage service
            let storageRef = storage.reference(forURL: "gs://fblogintest-35707.appspot.com")
            let profilePicRef = storageRef.child(user.uid+"/profile_pic.jpg")
            
            profilePicRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("unable to download image")
                } else {
                    // Data for "images/island.jpg" is returned
                    if(data != nil){
                        print("user already has an image no need to download from facebook")
                        self.uiImageProfilePic.image = UIImage(data:data!)
                    }
                }
            }
            
            if(self.uiImageProfilePic.image == nil){
                
                /*var profilePic = FBSDKGraphRequest(graphPath: "me/picture", parameters: ["height":200,"width":200,"redirect":false], httpMethod: "GET")
                profilePic?.start(completionHandler: {(connection, result, error) -> Void in
                    // Handle the result
                    if(error == nil){
                        let dictionary = result as? NSDictionary
                        let data = dictionary?.object(forKey: "data")
                        
                        let urlPic = ((data as AnyObject).object(forKey: "url"))! as! String
                        
                        if let imageData = NSData.init(contentsOf: NSURL(string:urlPic) as! URL){
                            
                            let uploadTask = profilePicRef.putData(imageData as Data, metadata: nil){
                                metadata,error in
                                
                                if(error == nil){
                                    
                                    //size,content type or download url
                                    let downloadUrl = metadata!.downloadURL
                                }
                                else{
                                    print("Error in downloading image")
                                }
                            }
                            
                            
                            self.uiImageProfilePic.image = UIImage(data:imageData as Data)
                        }
                    }
                })*/
            }//end if
            
        } else {
            // No user is signed in.
            // ...
        }
        
        
    }
}
