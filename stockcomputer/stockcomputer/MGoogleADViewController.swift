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

class MGoogleADViewController: UIViewController,GADBannerViewDelegate{
    var adBannerView: GADBannerView?
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        setAdBanner()
        
        if(checkRemoveAd()){
            adBannerView?.isHidden = true
        }else{
            adBannerView?.isHidden = false
        }
        
        
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
    
    func checkIsMember() ->Bool{
        let firebaseAuth = Auth.auth()
        if firebaseAuth != nil {
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
    
    func setMemberAlert(){
        
        let controller = UIAlertController(title: "提示", message:"您的身份為訪客 請先登入", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
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
                var lastTime :Int =  FirebaseManager.getLastLoginTime()
                print("checkLoginTime_last",lastTime)
                print("checkLoginTime_now",timeStamp)
                // 一天 毫秒 60 * 60 * 24 * 1000
                var now :Int = timeStamp - lastTime
                var dayTime : Int = 86400
                print("checkLoginTime_now",now)
                
                if( now < dayTime){
                    print("checkLoginTime","還沒到")
                    
                    
                }else{
                    print("checkLoginTime","到")
                    var message = "本次簽到時間:" + timeStanpToSring(timeStamp: Float(timeStamp)) + "是否簽到領取獎勵"
                    let controller = UIAlertController(title: "簽到提醒", message: message, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "是", style: .default) { (_) in
                        FirebaseManager.addMemberTimeAndPintToFirebase()
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
                    FirebaseManager.addMemberTimeAndPintToFirebase()
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


