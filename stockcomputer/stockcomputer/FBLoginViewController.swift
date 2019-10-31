//
//  FBLoginViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/4/24.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import Firebase
import FacebookLogin
import FacebookCore
import Instabug

class FBLoginViewController: UIViewController{
    let userDefaults = UserDefaults.standard
    @IBAction func guestLogin(_ sender: Any) {
        
        Auth.auth().signInAnonymously() { (authResult, error) in
            if let error = error {//
                print("error")

                print(error.localizedDescription)
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
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .userFriends,.email], viewController: self) { result in
            self.loginManagerDidComplete(result)
        }
    }
    func loginManagerDidComplete(_ result: LoginResult) {
        switch result {
        case .cancelled: break
        case .failed(let error): break
        case .success(let grantedPermissions, _, _):
            fetchProfile()
            break
            
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchProfile()
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func fetchProfile(){
        if ((userDefaults.value(forKey: "userID")) != nil){
            let stroyboard = UIStoryboard(name: "Main", bundle: nil);
                       let HomeVc = stroyboard.instantiateViewController(withIdentifier: "home")
                       let appDelegate = UIApplication.shared.delegate as! AppDelegate;
                       appDelegate.window?.rootViewController = HomeVc
            
        }else{
            if let accessToken = AccessToken.current {
                let stroyboard = UIStoryboard(name: "Main", bundle: nil);
                let HomeVc = stroyboard.instantiateViewController(withIdentifier: "home")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate;
                appDelegate.window?.rootViewController = HomeVc
                // User is logged in, use 'accessToken' here.
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    if let error = error {
                        
                        // ...
                        return
                    }
               Instabug.identifyUser(withEmail: (Auth.auth().currentUser?.email)!, name: Auth.auth().currentUser?.displayName)

                    
                }
            }
        }

    }
}
