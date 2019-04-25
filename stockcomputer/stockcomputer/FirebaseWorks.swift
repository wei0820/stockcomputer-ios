//
//  FirebaseWorks.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/4/25.
//  Copyright © 2019 jackpan. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit
let firebaseWorks = FirebaseWorks()

enum Result{
    case success
    case fail
}

class FirebaseWorks{
    
    func signInFireBaseWithFB(completion: @escaping (_ result: Result) -> ()){
        
        let fbAccessToken = FBSDKAccessToken.current()
        guard let fbAccessTokenString = fbAccessToken?.tokenString else { return }
        
        let fbCredentials = FacebookAuthProvider.credential(withAccessToken: fbAccessTokenString)
        firebaseSignInWithCredential(credential: fbCredentials, completion: completion)
    }
    

    
    func firebaseSignInWithCredential(credential: AuthCredential,completion: @escaping (_ result: Result) -> ()){
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil {
                //登入失敗 請重新登入
                print("Something went wrong with our FB user: ", error ?? "")
                return
            }else{
                
//                print("Successfully logged in with our user: ", user ?? "")
//
//                guard let uid = user?.uid else {
//                    return
//                }
//
//                guard let profileImageUrl = user?.photoURL?.absoluteString, let email = user?.email, let name = user?.displayName else{
//                    return
//                }
//                //可自行選擇想要上傳的使用者資料
//                let values = ["name": name as AnyObject, "email": email as AnyObject, "profileImageUrl": profileImageUrl as AnyObject] as [String: AnyObject]
//
//                let ref = FIRDatabase.database().reference()
//
//                let usersReference = ref.child("users").child(uid)
//
//                usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
//                    if err != nil{
//                        print(err!)
//                        return
//                    }
//
//                    completion(Result.success)
//
//                })
//
            }
        })
    }
    

    
   
    
}
