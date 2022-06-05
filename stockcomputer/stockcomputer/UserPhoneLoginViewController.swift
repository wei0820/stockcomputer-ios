//
//  UserPhoneLoginViewController.swift
//  ZEGOLiveDemo
//
//  Created by JackPan on 2022/5/17.
//

import UIKit
import Firebase

class UserPhoneLoginViewController: UIViewController {

    @IBOutlet weak var userphoneText: UITextField!
    
    @IBOutlet weak var verificationcodeText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userphoneText.keyboardType = .phonePad
//        setupGradientBackground(button: getVerificationCode,title: "驗證")
//        setupGradientBackground(button: sendButton,title: "送出")
//        sendButton.isEnabled = false
//        sendButton.alpha = 0.5

        

        // Do any additional setup after loading the view.
    }
    @IBAction func sendAction(_ sender: Any) {
        
        let verificationID :String = UserDefaults.standard.string(forKey: "authVerificationID")!
        let verificationCode = verificationcodeText.text!
        let credential = PhoneAuthProvider.provider().credential(
                  withVerificationID: verificationID,
                  verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
                  if let error = error {

                      // ...
                      return
                  }
            guard let user = authResult?.user else { return }
            let uid = user.uid
            let stroyboard = UIStoryboard(name: "Main", bundle: nil);
            let HomeVc = stroyboard.instantiateViewController(withIdentifier: "home")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate;
            appDelegate.window?.rootViewController = HomeVc
        }
        
        
        
    }
    @IBAction func getVerificationCodeAction(_ sender: Any) {

        if(userphoneText.text != nil && !userphoneText.text!.isEmpty){
                 if(userphoneText.text!.count >= 11){
                     return
                 }

        var phonenumber : String = String(userphoneText.text!.suffix(9))
            print("Jack",phonenumber)



        PhoneAuthProvider.provider().verifyPhoneNumber("+886" + phonenumber, uiDelegate: nil) { (verificationID, error) in
                    if let error = error {

                        print("Jack",error.localizedDescription)

                        return
                    }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            print("Jack",verificationID)



                    // ...
                }
                Auth.auth().languageCode = "tw";
           
        }
//
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setupGradientBackground(button : UIButton,title :String) {


        let gradientLayer = CAGradientLayer()
       gradientLayer.frame.size = button.frame.size
        gradientLayer.colors = [
           UIColor(red: 0.56, green: 0, blue: 1, alpha: 1).cgColor,

             UIColor(red: 0.296, green: 0.505, blue: 0.912, alpha: 1).cgColor,

             UIColor(red: 0.038, green: 1, blue: 0.827, alpha: 1).cgColor
           
        ]
       

       gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)

       gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
       
        button.layer.addSublayer(gradientLayer)
        button.setTitle(title, for: .normal)

        

    }
    
}


        

