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
import AuthenticationServices
import CryptoKit
import Security

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)

class FBLoginViewController: UIViewController,ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding{
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
            return self.view.window!
     }
  
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
                
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            print("jack","user: \(appleIDCredential.user)")
            print("jack","fullName: \(String(describing: appleIDCredential.fullName))")
            print("jack","Email: \(String(describing: appleIDCredential.email))")
            print("jack","realUserStatus: \(String(describing: appleIDCredential.realUserStatus))")
             guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
              }

              guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
              }
              guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
              }
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                       idToken: idTokenString,
                                                       rawNonce: nonce)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if (error != nil) {
                     // Error. If error.code == .MissingOrInvalidNonce, make sure
                     // you're sending the SHA256-hashed nonce as a hex string with
                     // your request to Apple.
                     return
                   }
            }
            userDefaults.set((appleIDCredential.user), forKey: "userID")
            fetchProfile()
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
                
        switch (error) {
        case ASAuthorizationError.canceled:
            break
        case ASAuthorizationError.failed:
            break
        case ASAuthorizationError.invalidResponse:
            break
        case ASAuthorizationError.notHandled:
            break
        case ASAuthorizationError.unknown:
            break
        default:
            break
        }
                    
        print("didCompleteWithError: \(error.localizedDescription)")
    }
    let userDefaults = UserDefaults.standard
    fileprivate var currentNonce: String?

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
        
        if #available(iOS 13.0, *) {
            let nonce = randomNonceString()
            currentNonce = nonce
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            request.nonce = sha256(nonce)

            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManager.getStockcomuperAllDate()
        FirebaseManager.getBannerDate()
        fetchProfile()

    }
    private func checkCredentialState(withUserID userID: String) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userID) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                // 用戶已登入
                print("Jack","用戶已登入")
                break
            case .revoked:
                // 用戶已登出
                print("Jack","用戶已登出")

                break
            case .notFound:
                // 無此用戶
                print("Jack","無此用戶")
                break;
            default:
                break
            }
        }
    }

    func fetchProfile(){
        if ((userDefaults.value(forKey: "userID")) != nil){
            let stroyboard = UIStoryboard(name: "Main", bundle: nil);
            let HomeVc = stroyboard.instantiateViewController(withIdentifier: "home")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate;
            appDelegate.window?.rootViewController = HomeVc
            let id : String = userDefaults.value(forKey: "userID") as! String
            self.checkCredentialState(withUserID: id)
        }
    
}
    private func randomNonceString(length: Int = 32) -> String {
       precondition(length > 0)
       let charset: Array<Character> =
           Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
       var result = ""
       var remainingLength = length

       while remainingLength > 0 {
         let randoms: [UInt8] = (0 ..< 16).map { _ in
           var random: UInt8 = 0
           let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
           if errorCode != errSecSuccess {
             fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
           }
           return random
         }

         randoms.forEach { random in
           if remainingLength == 0 {
             return
           }

           if random < charset.count {
             result.append(charset[Int(random)])
             remainingLength -= 1
           }
         }
       }

       return result
     }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
   
    
}
