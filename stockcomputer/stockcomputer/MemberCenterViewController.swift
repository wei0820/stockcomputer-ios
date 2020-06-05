//
//  MemberCenterViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/7.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase
import StoreKit
import JGProgressHUD

class MemberCenterViewController: MUIViewController ,GADBannerViewDelegate ,GADRewardBasedVideoAdDelegate{
    var hud :JGProgressHUD?
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var rewardbtn: UIButton!
    @IBOutlet weak var shopbtn: UIButton!


    @IBOutlet weak var lasttime: UILabel!
    @IBAction func back(_ sender: Any) {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil);
        let HomeVc = stroyboard.instantiateViewController(withIdentifier: "home")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.window?.rootViewController = HomeVc
        
    }
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        var point : Int = FirebaseManager.getUserPoint()
        var updatePoint : Int = point + Int(reward.amount)
        FirebaseManager.addMemberWatchAdFirebase(pont: updatePoint)
        FirebaseManager.getMemberDate()

    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad has completed.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load.")
    }
    var adBannerView: GADBannerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAdBanner()
        shopbtn.isHidden = true
        if(checkIsMember()){
            rewardbtn.isHidden = false
            
        }else{
            rewardbtn.isHidden = true
            
        }
        
        get()
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-7019441527375550/4519858733")
        //        self.productIDs.append("Member_Point_1000")
        //        self.productIDs.append("MenberPoint_1000"
        
        
        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    func setAdBanner(){
        let id = "ca-app-pub-7019441527375550/2358814075"
        adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView!.adUnitID = id
        adBannerView!.delegate = self
        adBannerView!.rootViewController = self
        
        adBannerView!.load(GADRequest())
    }
    @IBAction func restart(_ sender: Any) {
        let controller = UIAlertController(title: "復原購買", message: "是否復原購買?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "是", style: .default) { (_) in
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
        
    }
    /*
     
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    // Called when an ad request loaded an ad.
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
    @IBAction func about(_ sender: Any) {
        let controller = UIAlertController(title: "會員點數", message: "用於一些需要的地方！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
        
    }
    @IBOutlet weak var mid: UILabel!
    
    @IBAction func logout(_ sender: Any) {
        userDefaults.set(nil, forKey: "userID")
        
        
        //   123456
        //
        let stroyboard = UIStoryboard(name: "Main", bundle: nil);
        let HomeVc = stroyboard.instantiateViewController(withIdentifier: "login")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.window?.rootViewController = HomeVc
        
    }
    
    
    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var photoimg: UIImageView!
    @IBOutlet weak var mPoint: UILabel!
    func get(){
        let firebaseAuth = Auth.auth()
        if firebaseAuth != nil {
            if(checkIsMember()){
                lasttime.text = "上次登入時間:" + TimerManager.timeStampToDate(timestamp: FirebaseManager.getUserLlastlogintime())
            }else{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                var dateString = dateFormatter.string(from: (Auth.auth().currentUser?.metadata.lastSignInDate)!)
                lasttime.text = "最後登入時間:" + dateString
            }
            
            
            
            if(firebaseAuth.currentUser!.isAnonymous){
                mid.text = "ID:" + "遊客身份"
                mName.text = "姓名:" + "遊客身份"
                mPoint.text = "點數:"+"遊客身份"
            }else{
                
                
                mid.text = "ID:" + (Auth.auth().currentUser?.uid)!
                mName.text = "姓名:" + (Auth.auth().currentUser?.displayName)!
                mPoint.text = "點數:" + String(FirebaseManager.getUserPoint())
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData:NSData = NSData(contentsOf: (Auth.auth().currentUser?.photoURL)!)!
                    // When from background thread, UI needs to be updated on main_queue
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData as Data)
                        self.photoimg.image = image
                    }
                }
                
            }
        }
        
    }
    var mTitle :String = ""
    @IBAction func shop(_ sender: Any) {

        
    }
    @IBAction func watch(_ sender: Any) {
        
        let controller = UIAlertController(title: "觀看影片", message: "是否觀看影片來得到點數", preferredStyle: .actionSheet)
        let names = [ "是", "否"]
        for name in names {
            let action = UIAlertAction(title: name, style: .default) { (action) in
                if (name == "是"){
                    if(FirebaseManager.getUserWatchTime() != nil
                        && FirebaseManager.getUserWatchTime() != 0 )
                    {
                        // 一天 毫秒 60 * 60 * 24 * 1000
                        var watchLastTime : Int = FirebaseManager.getUserWatchTime()
                        var watchNoeTime : Int = FirebaseManager.getLastLoginTime()

                        if(watchNoeTime - watchLastTime > 60 * 60 * 6){
                            self.watchAdVideo()
                            
                        }else{
                            
                            let controller = UIAlertController(title: "提示", message: "六小時才能領取一次唷", preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: "好的", style: .cancel, handler: nil)
                            controller.addAction(cancelAction)
                            self.present(controller, animated: true, completion: nil)
                            
                            
                        }
                        
                    }else{
                    
                        self.watchAdVideo()
                    }
                    
                    
                    
                }else{
                    
                }
            }
            controller.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    func setUIAlert(title :String ,message :String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    func watchAdVideo(){
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
        FirebaseManager.addWatchADTimeToFirebase(watchTime: FirebaseManager.getLastLoginTime())
        FirebaseManager.getMemberDate()

        
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
    
}
