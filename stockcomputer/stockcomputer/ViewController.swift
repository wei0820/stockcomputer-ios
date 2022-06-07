//
//  ViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/2/2.
//  Copyright © 2019 jackpan. All rights reserved.
//
import SideMenu

import UIKit
import GoogleMobileAds
import Firebase
import Instabug
import JGProgressHUD
import MarqueeLabel
import LLCycleScrollView
import YoutubePlayerView

class ViewController: MGoogleADViewController,UITabBarDelegate{

    @IBOutlet weak var bannerView: LLCycleScrollView!

    @IBOutlet weak var CurrentPrice: UIView!
    var ref: DatabaseReference!
    var strings = [String]()
//    @IBOutlet weak var playerView: YoutubePlayerView!
    @IBOutlet weak var marqueeLabel: MarqueeLabel!
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            
                
            if(!checkIsMember()){
                    return
                    }
            setJump(type: "DayTrade")
              Firebase.Analytics.logEvent("選擇項目", parameters: [
                "時間": DateManager.setDate(),
                "名稱": "當沖獲利試算"
            ])
            break
        case 2:
            setJump(type: "sellput")
            Firebase.Analytics.logEvent("選擇項目", parameters: [
                     "時間": DateManager.setDate(),
                     "名稱": "選擇權試算"
                 ])
        
            break
        case 3:
                
            if(!checkIsMember()){
                    return
                    }
            setJump(type: "futures")
            Firebase.Analytics.logEvent("選擇項目", parameters: [
                             "時間": DateManager.setDate(),
                             "名稱": "期貨獲利試算"
                         ])
            break
        case 4:
            setJump(type: "StockPeriod")
            Firebase.Analytics.logEvent("選擇項目", parameters: [
                                     "時間": DateManager.setDate(),
                                     "名稱": "個股期獲利試算"
                                 ])
            break
        case 5:
            setJump(type: "warrrant")
            Firebase.Analytics.logEvent("選擇項目", parameters: [
                                      "時間": DateManager.setDate(),
                                      "名稱": "權證獲利試算"
                                  ])
            
            break
            
        default:
            
            break
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        setBannerView()
//        setYt()
        setUIView()
        getStockcomuperAllDate()
        Firebase.Analytics.setScreenName("首頁", screenClass: "ViewController")
        marqueeLabel.type = .continuous
        marqueeLabel.speed = .duration(9)
        marqueeLabel.animationCurve = .easeInOut
        marqueeLabel.fadeLength = 10.0
        marqueeLabel.leadingBuffer = 30.0
        marqueeLabel.trailingBuffer = 20.0
        setupSideMenu()
        
//        if(checkIsMember()){
//            getId()
//
//            if(!FirebaseManager.getVersion().isEmpty){
//                var newVersion : Double = FirebaseManager.getNewVersion() as! Double
//                var userVersion : Double = Double(FirebaseManager.getVersion()) as! Double
//                if(userVersion < newVersion){
//                    setAlert(title: "版本過舊", message: "請您至 App Store 更新 ")
//                }
//
//            }
//
//        }
    
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if(checkIsMember()){
            FirebaseManager.getMemberDate()

        }
        
    }
    func getId(){
        if ((userDefaults.value(forKey: "userID")) != nil){
            let id : String = userDefaults.value(forKey: "userID") as! String
            FirebaseManager.setPhoneMember(id:id)

        
        }else{

        }
    }
//    func setYt(){
//
//   let playerVars: [String: Any] = [
//             "controls": 1,
//             "modestbranding": 1,
//             "playsinline": 1,
//             "origin": "https://youtube.com"
//         ]
//        Database.database().reference().child("youtubeid").child("youtubeid" as! String).observe(.childAdded, with: {
//              (snapshot) in
//              // childAdded逐筆呈現
//              if let dictionaryData = snapshot.value as? [String: AnyObject]{
//                  var announcement : String = dictionaryData["youtubeid"] as! String
//                self.playerView.delegate = self as! YoutubePlayerViewDelegate
//
//                self.playerView.loadWithVideoId(announcement, with: playerVars)
//
//
//
//              }
//
//          }, withCancel: nil)news
//
//    }
    func setBannerView(){
        self.bannerView.imagePaths = FirebaseManager.getPageArray()
        self.bannerView.imageViewContentMode = .scaleToFill
        self.bannerView.customPageControlStyle = .image
        self.bannerView.pageControlPosition = .center
        // 是否对url进行特殊字符处理
        self.bannerView.isAddingPercentEncodingForURLString = true
        self.bannerView.pageControlCurrentPageColor = .white
        bannerView.customPageControlInActiveTintColor = .white


        // 2018-02-25 新增协议
    }
    

    func setUIAlert(title :String ,message :String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            FirebaseManager.getMemberDate()
        }
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    func setAlert(title :String ,message :String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
        }
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    func setNoLoginAlert(title :String ,message :String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    func setUIView(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.CurrentPrice.addGestureRecognizer(gesture)

    }
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
        setJump(type: "CurrentPrice")
    }
    
  func getStockcomuperAllDate(){
        Database.database().reference().child("stockcomuper").child("stockcomuper" as! String).observe(.childAdded, with: {
            (snapshot) in
            // childAdded逐筆呈現
            if let dictionaryData = snapshot.value as? [String: AnyObject]{
                var announcement : String = dictionaryData["announcement"] as! String
                print("Jack",announcement)
                self.strings = [announcement]
                self.marqueeLabel.text = self.strings[Int(arc4random_uniform(UInt32(self.strings.count)))]

            }
            
        }, withCancel: nil)
    }
   
}
extension ViewController: YoutubePlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YoutubePlayerView) {
        print("Ready")
        playerView.play()
    }
    
    func playerView(_ playerView: YoutubePlayerView, didChangedToState state: YoutubePlayerState) {
        print("Changed to state: \(state)")
    }
    
    func playerView(_ playerView: YoutubePlayerView, didChangeToQuality quality: YoutubePlaybackQuality) {
        print("Changed to quality: \(quality)")
    }
    
    func playerView(_ playerView: YoutubePlayerView, receivedError error: Error) {
        print("Error: \(error)")
    }
    
    func playerView(_ playerView: YoutubePlayerView, didPlayTime time: Float) {
        print("Play time: \(time)")
    }
    
    func playerViewPreferredInitialLoadingView(_ playerView: YoutubePlayerView) -> UIView? {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
  
    private func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
    
        
        
    }
   
}
extension ViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}

