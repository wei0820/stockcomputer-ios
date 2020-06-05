//
//  FBLoginViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/4/24.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import Firebase
import Instabug
class FBLoginViewController: UIViewController{

    let userDefaults = UserDefaults.standard
    func setJump(type:String){
         
         if let controller = storyboard?.instantiateViewController(withIdentifier: type) {
                    present(controller, animated: true, completion: nil)
                }
         
     }
    @IBAction func guestLogin(_ sender: Any) {
        
        Auth.auth().signInAnonymously() { (authResult, error) in
            if let error = error {//
                return
            }
            guard let user = authResult?.user else { return }
            let isAnonymous = user.isAnonymous  // true
            let uid = user.uid
            
            self.userDefaults.set(uid, forKey: "userID")
            self.userDefaults.set(isAnonymous, forKey: "isAnonymous")
            
            let stroyboard = UIStoryboard(name: "Main", bundle: nil);
            let HomeVc = stroyboard.instantiateViewController(withIdentifier: "home")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate;
            appDelegate.window?.rootViewController = HomeVc
        }
    }
    
    @IBAction func fblogin_(_ sender: Any) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManager.getStockcomuperAllDate()
        fetchProfile()
        FirebaseManager.getBannerDate()
    }
    
    func fetchProfile(){
        if ((userDefaults.value(forKey: "userID")) != nil){
            let stroyboard = UIStoryboard(name: "Main", bundle: nil);
            let HomeVc = stroyboard.instantiateViewController(withIdentifier: "home")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate;
            appDelegate.window?.rootViewController = HomeVc

            
        }else{
//            if let accessToken = AccessToken.current {
//                let stroyboard = UIStoryboard(name: "Main", bundle: nil);
//                let HomeVc = stroyboard.instantiateViewController(withIdentifier: "home")
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate;
//                appDelegate.window?.rootViewController = HomeVc
//
//                // User is logged in, use 'accessToken' here.
//                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
//
//                Auth.auth().signIn(with: credential) { (authResult, error) in
//                    if let error = error {
//
//                        return
//                    }
//                    FirebaseManager.getMemberDate()
//                    if(FirebaseManager.getUserId() != nil && FirebaseManager.getUserPoint() != nil){
//                        if(FirebaseManager.getUserPoint() == 0){
//                            FirebaseManager.addMemberDateToFirebase(point: 100)
//                        }
//
//                    }else{
//                        FirebaseManager.addMemberDateToFirebase(point: 100)
//                        FirebaseManager.getMemberDate()
//                    }
//
//                }
//            }
        }
    
    
}
}
