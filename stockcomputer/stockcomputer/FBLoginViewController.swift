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
import Toaster

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)

class FBLoginViewController: UIViewController,ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding, UITextFieldDelegate {
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var sendbtn: UIButton!
    
    @IBOutlet weak var getCode: UIButton!
    
    @IBAction func get(_ sender: Any) {
        if(phone.text != nil && !phone.text!.isEmpty){
            if(phone.text!.count >= 11){
                Toast.init(text:"請檢查手機號碼").show()
                return
            }
            
            var phonenumber : String = String(phone.text!.suffix(9))
       

                   PhoneAuthProvider.provider().verifyPhoneNumber("+886" + phonenumber, uiDelegate: nil) { (verificationID, error) in
                               if let error = error {
                                   print("error")

                                   print("Jack",error.localizedDescription)

                                   return
                               }
                               // Sign in using the verificationID and the code sent to the user
                               UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    self.number.isHidden = false
                    self.sendbtn.isHidden = false


                               // ...

                           }
                           Auth.auth().languageCode = "tw";
        }
    }
    
    @IBAction func send(_ sender: Any) {
        let verificationID :String = UserDefaults.standard.string(forKey: "authVerificationID")!
        let verificationCode = number.text!
        let credential = PhoneAuthProvider.provider().credential(
                  withVerificationID: verificationID,
                  verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
                  if let error = error {
                    self.getError(S: error.localizedDescription)

                      // ...
                      return
                  }
            guard let user = authResult?.user else { return }
            let uid = user.uid
            
            self.userDefaults.set(uid, forKey: "userID")
                
            
            self.fetchProfile()
        }
        
    }
    
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
            
            self.fetchProfile()

        }
    }
    
    @IBAction func fblogin_(_ sender: Any) {
        
        phone.isHidden = false
        getCode.isHidden = false



    }
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManager.getStockcomuperAllDate()
        FirebaseManager.getBannerDate()
        fetchProfile()
        phone.isHidden = true
        number.isHidden = true
        sendbtn.isHidden = true
        getCode.isHidden = true
        if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .light
            } else {
                // Fallback on earlier versions
            }
        
        phone.borderStyle = .roundedRect
        phone.returnKeyType = .done
        phone.delegate = self
        phone.keyboardType = .numberPad
        phone.clearButtonMode = .always  //一直显示清除按钮
        number.borderStyle = .roundedRect
        number.clearButtonMode = .always  //一直显示清除按钮
        number.textContentType = .oneTimeCode
        number.keyboardType = .numberPad

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
            if ((userDefaults.value(forKey: "isAnonymous")) != nil){
                var isAnonymous : Bool = userDefaults.value(forKey: "isAnonymous") as! Bool

                if(!isAnonymous){
               
                }else{
         
                }
                
            }
            
        }else{

     

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
    func textFieldShouldReturn(textField: UITextField) -> Bool {
         // 結束編輯 把鍵盤隱藏起來
         self.view.endEditing(true)
         
         return true
     }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
     }
    func getError(S :String){
        let controller = UIAlertController(title: "發生錯誤", message: S, preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                   controller.addAction(okAction)
                   present(controller, animated: true, completion: nil)
    }
}
