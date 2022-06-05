//
//  UserLoginViewController.swift
//  ZEGOLiveDemo
//
//  Created by JackPan on 2022/5/16.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn
import Firebase
import AuthenticationServices
import CryptoKit
class UserLoginViewController: UIViewController, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows[0]

    }
 


    @IBOutlet weak var rightView: UIView!
    
    @IBOutlet weak var fbLoginView: UIView!
    
    @IBOutlet weak var googleLoginVIew: UIView!
    
    @IBOutlet weak var appleIdLoginView: UIView!
    
    @IBOutlet weak var phoneLoginVIew: UIView!
    
    @IBOutlet weak var qusetLoginView: UIView!
    @IBOutlet weak var mView: UIView!
    
    fileprivate var currentNonce: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewGradientLayer()
        initFbLogin()
        initGoogleLogin()
        initAppleIdLogin()
        initUserPhoneLogin()
        initLineLogin()
  
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
          // User is signed in.
            print("UserLoginViewController"," User is signed in.")
            let user = Auth.auth().currentUser
            if let user = user {
              // The user's ID, unique to the Firebase project.
              // Do NOT use this value to authenticate with your backend server,
              // if you have one. Use getTokenWithCompletion:completion: instead.
              let uid = user.uid
                print("UserLoginViewController",uid)
                self.nextPage()

            }
              // ...
          // ...
        } else {
          
          // ...
            print("UserLoginViewController","// No user is signed in.")

        }
    }
    func setViewGradientLayer(){
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = view.frame.size
        gradientLayer.colors = [
            UIColor(red: 0.9, green: 0, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.2, green: 1, blue: 0.6, alpha: 1).cgColor]
        
        mView.layer.addSublayer(gradientLayer)
        self.mView.layer.cornerRadius = CGFloat(80)
        self.mView.clipsToBounds = true
        self.mView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        let gradientLayer2 = CAGradientLayer()
        gradientLayer2.frame.size = view.frame.size
        gradientLayer2.colors = [
            UIColor(red: 0.56, green: 0, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.038, green: 1, blue: 0.827, alpha: 1).cgColor]
        
        
        rightView.layer.addSublayer(gradientLayer2)
        self.rightView.layer.cornerRadius = CGFloat(80)
        self.rightView.clipsToBounds = true
        self.rightView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        
    }
    func initFbLogin(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.fbLoginAction))
        self.fbLoginView.addGestureRecognizer(gesture)
    }
    @objc func fbLoginAction(sender : UITapGestureRecognizer) {
        
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile], viewController: self) { (result) in
            if case LoginResult.success(granted: _, declined: _, token: let token) = result {
                
                let credential =  FacebookAuthProvider.credential(withAccessToken: token!.tokenString)
                Auth.auth().signIn(with: credential) { [weak self] (result, error) in
                    guard let self = self else { return }
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    print("login ok")
                    self.nextPage()

                }
                
            } else {
                print("login fail")
            }
        }
        
        
        
    }
    
    func initGoogleLogin(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.googleLoginAction))
        self.googleLoginVIew.addGestureRecognizer(gesture)
    }
    
    @objc func googleLoginAction(sender : UITapGestureRecognizer) {
        print("jack","in")

        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            
            if let error = error {
                print("jack",error.localizedDescription)
                return
            }
            print("jack", user?.authentication)
            print("jack",user?.authentication.idToken)
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
        
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
        

            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    
                    print("jack",error.localizedDescription)
                    
                    
                    return
                }
                // User is signed in
                print("jack","User is signed in")
                self.nextPage()


                // ...
            }
            
        }
        
    }
    func initAppleIdLogin(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.appleIdLoginAction))
        self.appleIdLoginView.addGestureRecognizer(gesture)
    }
    
    @objc func appleIdLoginAction(sender : UITapGestureRecognizer) {
        
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
        
    }
//    func initGuestLogin(){
//        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.guestLoginAction))
//        self.guestLoginView.addGestureRecognizer(gesture)
//
//    }
    @objc func guestLoginAction(sender : UITapGestureRecognizer) {
        
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else { return }
            let isAnonymous = user.isAnonymous  // true
            let uid = user.uid
            self.nextPage()
            
            
        }
        
    }
    func initLineLogin(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.lineLoginAction))
        self.phoneLoginVIew.addGestureRecognizer(gesture)
        
    }
    @objc func lineLoginAction(sender : UITapGestureRecognizer) {

        let next = self.storyboard?.instantiateViewController(withIdentifier: "userphonelogin")
        
        self.present(next!, animated: true, completion: nil)
    }
    
    func initUserPhoneLogin(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.userPhoneLoginAction))
        self.qusetLoginView.addGestureRecognizer(gesture)
        
        
    }
    @objc func userPhoneLoginAction(sender : UITapGestureRecognizer) {
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else { return }
            let isAnonymous = user.isAnonymous  // true
            let uid = user.uid
            self.nextPage()
        }
      
    }
    
    
    
    
    
    
    func  nextPage(){
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
//        mainTabBarController.modalPresentationStyle = .fullScreen
//        self.present(mainTabBarController, animated: true, completion: nil)
//
//        if let controller = storyboard?.instantiateViewController(withIdentifier: "homevc") {
//            present(controller, animated: true, completion: nil)
//
//
//        }
 
        
        let stroyboard = UIStoryboard(name: "Main", bundle: nil);
        let HomeVc = stroyboard.instantiateViewController(withIdentifier: "home")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.window?.rootViewController = HomeVc


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
@available(iOS 13.0, *)
extension UserLoginViewController: ASAuthorizationControllerDelegate {

  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
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
      // Initialize a Firebase credential.
      let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                idToken: idTokenString,
                                                rawNonce: nonce)
      // Sign in with Firebase.
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                
                print("jack",error.localizedDescription)
                
                
                return
            }
            // User is signed in
            print("jack","User is signed in")
            
            self.nextPage()

            // ...
        }
    }
  }

  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error.
    print("Sign in with Apple errored: \(error)")
  }

}
