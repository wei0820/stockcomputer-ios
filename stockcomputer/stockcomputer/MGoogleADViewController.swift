//
//  MGoogleADViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/8.
//  Copyright © 2019 jackpan. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds
import Toaster
import Firebase
import Instabug
import SwiftyStoreKit
import AuthenticationServices
import AudioToolbox.AudioServices
class MGoogleADViewController: UIViewController,GADBannerViewDelegate{
    var adBannerView: GADBannerView?
    let userDefaults = UserDefaults.standard
    var productIDs: [String] = [String]()
    override func viewDidLoad() {
       
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        setAdBanner()
        getAnnouncement()
        check()
                
    }
    override func viewWillAppear(_ animated: Bool) {
        check()
    }
    func setScreenName(screenName :String ,screenClassName :String){
        Firebase.Analytics.setScreenName(screenName, screenClass: screenClassName)

    }
    private func observeAppleIDSessionChanges() {
        if #available(iOS 13.0, *) {
            NotificationCenter.default.addObserver(forName: ASAuthorizationAppleIDProvider.credentialRevokedNotification, object: nil, queue: nil) { (notification: Notification) in
                // Sign user in or out
                print("Jack","Sign user in or out...")
            }
        } else {
            // Fallback on earlier versions
        }
    }
    func check(){

        
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "05c23e4de2a14cad935a56b657dd0698")
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productIds = Set([ "remove_ad_month",
                                       "remove_six_month",
                                       "remove_ad_year"])
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: productIds, inReceipt: receipt)
                switch purchaseResult {
                case .purchased(let expiryDate, let items):
                    self.adBannerView?.isHidden = true
                    Firebase.Analytics.logEvent("訂閱項目", parameters: [
                                             "訂閱戶": "是",
                                             "購買商品": items.description,
                                         ])
                case .expired(let expiryDate, let items):
                    self.adBannerView?.isHidden = false
                    Firebase.Analytics.logEvent("訂閱項目", parameters: [
                                                             "訂閱戶": "否",
                                                             "購買商品": items.description,
                                                         ])
                case .notPurchased:
                    Firebase.Analytics.logEvent("訂閱項目", parameters: [
                                                             "有無訂閱": "否",
                                                             "購買商品": "非訂閱戶",
                                                         ])
                    self.adBannerView?.isHidden = false

                }
            case .error(let error):
                print("jack","Receipt verification failed: \(error)")
            }
        }
    }

    
    func getAnnouncement(){
        FirebaseManager.getStockcomuperAllDate()
        
    }
    func setAdBanner(){
        let id = "ca-app-pub-7019441527375550/9487446087"
        adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView!.adUnitID = id
        adBannerView!.delegate = self
        adBannerView!.rootViewController = self
        adBannerView!.load(GADRequest())
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        addBannerViewToView(bannerView)
        
    }
    
    // Called when an ad request failed.
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print((error.localizedDescription))
    }
    
    // Called just before presenting the user a full screen view, such as a browser, in response to
    // clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just before dismissing a full screen view.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just after dismissing a full screen view.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just before the application will background or terminate because the user clicked on an
    // ad that will launch another application (such as the App Store).
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print(#function)
    }
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
        ])
    }
    
    func checkRemoveAd() ->Bool {
        var removeAd = userDefaults.value(forKey: "removeAd")
        return (removeAd != nil)
        
    }
    func getUserID() -> String{
        var userID = userDefaults.value(forKey: "userID")
        if userID != nil {
            return userID as! String

        }
        return ""
        
    }
    
    
    
    func checkIsMember() ->Bool{
        let firebaseAuth = Auth.auth()
        if firebaseAuth != nil {
            
            if firebaseAuth.currentUser == nil {
                         return false
                       }
            
            if firebaseAuth.currentUser!.isAnonymous == nil {
              return false
            }
            
            if(firebaseAuth.currentUser!.isAnonymous){
                
                return false
                
            }else{
                return true
                
            }
        }
        return false
    }
    
    func setToast(s:String){
        Toast.init(text: s).show()
    }
    func dissmissView(){
        dismiss(animated: true, completion: nil)
        
    }
    func setJump(type:String){
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: type) {
            present(controller, animated: true, completion: nil)
        }
        
    }
    
    
    func setMemberAlert(){
        
        let controller = UIAlertController(title: "您的身份為訪客", message:"建議正式登入避免資料消失,是否繼續操作", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "是", style: .default) { (_) in
                   }
                   controller.addAction(okAction)
                   let cancelAction = UIAlertAction(title: "否", style: .cancel, handler: nil)
                   controller.addAction(cancelAction)
                   present(controller, animated: true, completion: nil)
    }
    func setVibrate(){
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }
    
    func checkLoginTime () {
        print("checkLoginTime_last", FirebaseManager.getUserLlastlogintime())
        let now = Date()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        print("当前日期时间：\(dformatter.string(from: now))")
        //当前时间的时间戳
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        print("当前时间的时间戳：\(timeStamp)")
        
        if(checkIsMember()){
            //获取当前时间
            if(FirebaseManager.getUserLlastlogintime() != nil &&  FirebaseManager.getUserLlastlogintime() != 0){
                var lastTime :Int =  FirebaseManager.getUserLlastlogintime()
                // 一天 毫秒 60 * 60 * 24 * 1000
                var now :Int = timeStamp - lastTime
                var dayTime : Int = 86400
                if( now < dayTime){
                    let controller = UIAlertController(title: "提示", message: "本次已經簽到過 請明天之後再來簽到", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "好的", style: .default) { (_) in
                    }
                    controller.addAction(okAction)
                    present(controller, animated: true, completion: nil)
                    
                }else{
                    var message = "本次簽到時間:" + timeStanpToSring(timeStamp: Float(timeStamp)) + "是否簽到領取獎勵"
                    let controller = UIAlertController(title: "簽到提醒", message: message, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "是", style: .default) { (_) in
                        FirebaseManager.addMemberTimeAndPintToFirebase(timestamp: timeStamp)
                    }
                    controller.addAction(okAction)
                    let cancelAction = UIAlertAction(title: "否", style: .cancel, handler: nil)
                    controller.addAction(cancelAction)
                    present(controller, animated: true, completion: nil)
                    
                }
                
                
            }else{
                var message = "本次簽到時間:" + timeStanpToSring(timeStamp: Float(timeStamp)) + "是否簽到領取獎勵"
                let controller = UIAlertController(title: "簽到提醒", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "是", style: .default) { (_) in
                    FirebaseManager.addMemberTimeAndPintToFirebase(timestamp: timeStamp)
                }
                controller.addAction(okAction)
                let cancelAction = UIAlertAction(title: "否", style: .cancel, handler: nil)
                controller.addAction(cancelAction)
                present(controller, animated: true, completion: nil)
                
            }
        }
        
        
    }
    
}
func getMemberDateList(){
    
    let firebaseAuth = Auth.auth()
    if firebaseAuth != nil {
        if(!firebaseAuth.currentUser!.isAnonymous){
            
            (Auth.auth().currentUser?.uid)!
            (Auth.auth().currentUser?.displayName)!
            
            
        }
        
    }
    
}
func logout(){
   try! Auth.auth().signOut()
    
}


func timeStanpToSring (timeStamp :Float) -> String{
    //转换为时间
    let timeInterval:TimeInterval = TimeInterval(timeStamp)
    let date = Date(timeIntervalSince1970: timeInterval)
      
    //格式话输出
    let dformatter = DateFormatter()
    dformatter.dateFormat = "yyyy年MM月dd日 HH:mm"
    print("对应的日期时间：\(dformatter.string(from: date))")
    return (dformatter.string(from: date))
}









