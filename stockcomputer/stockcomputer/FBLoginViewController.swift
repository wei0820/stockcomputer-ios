//
//  FBLoginViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/4/24.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase


class FBLoginViewController: UIViewController , FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        fetchProfile()

    }
    
    @IBOutlet weak var fblogin: FBSDKLoginButton!
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fblogin.readPermissions = ["public_profile", "email", "user_friends"]
        fblogin.delegate = self
        
        //        第一次登入後可取得使用者token，後續即可直接登入
        if (FBSDKAccessToken.current()) != nil{
                        fetchProfile()
            
        }
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
        print("attempt to fetch profile......")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {
            connection, result, error -> Void in
            
            if error != nil {
                print("登入失敗")
                print("longinerror =\(error)")
            } else {
                
                if let resultNew = result as? [String:Any]{
                    
                    print("成功登入")
                    
                    let email = resultNew["email"]  as! String
                    print(email)
                    
                    let firstName = resultNew["first_name"] as! String
                    print(firstName)
                    
                    let lastName = resultNew["last_name"] as! String
                    print(lastName)
                    
                    if let picture = resultNew["picture"] as? NSDictionary,
                        let data = picture["data"] as? NSDictionary,
                        let url = data["url"] as? String {
                        print(url) //臉書大頭貼的url, 再放入imageView內秀出來
                        
                   
                    }
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    
                    Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                        if let error = error {
                            // ...
                            return
                        }
                        // User is signed in
                        // ...
                    }
                    

                }
                
              
                let next = self.storyboard?.instantiateViewController(withIdentifier: "home")
                
                self.present(next!, animated: true, completion: nil)
            }
        })
    }
}
