//
//  ViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/2/2.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase
import Instabug
import JGProgressHUD
import MarqueeLabel
import LLCycleScrollView
class ViewController: MGoogleADViewController,UITabBarDelegate{
    
    @IBOutlet weak var FinancingView: UIView!
    @IBOutlet weak var MarginView: UIView!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var paymeView: UIView!
    @IBOutlet weak var bannerView: LLCycleScrollView!
    @IBOutlet weak var mOtherView: UIView!
    
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var CurrentPrice: UIView!
    
    var ref: DatabaseReference!
    var strings = [String]()

    @IBOutlet weak var marqueeLabel: MarqueeLabel!
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
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
            
            setJump(type: "futures")
            Firebase.Analytics.logEvent("選擇項目", parameters: [
                             "時間": DateManager.setDate(),
                             "名稱": "期貨獲利試算"
                         ])
            break
        case 4:
            setToast(s: "下個版本推出")
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
        setUIView()
//        setRightButton(s: "會員中心")
//        setLeftButton(s: "簽到")
        Firebase.Analytics.setScreenName("首頁", screenClass: "ViewController")
        marqueeLabel.type = .continuous
        marqueeLabel.speed = .duration(9)
        marqueeLabel.animationCurve = .easeInOut
        marqueeLabel.fadeLength = 10.0
        marqueeLabel.leadingBuffer = 30.0
        marqueeLabel.trailingBuffer = 20.0
        
        if(checkIsMember()){
            getId()
            
            if(!FirebaseManager.getVersion().isEmpty){
                var newVersion : Double = FirebaseManager.getNewVersion() as! Double
                var userVersion : Double = Double(FirebaseManager.getVersion()) as! Double
                if(userVersion < newVersion){
                    setAlert(title: "版本過舊", message: "請您至 App Store 更新 ")
                }
                
            }
            
        }
        getStockcomuperAllDate()
        
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
    
    func setLeftButton(s: String){
        // 導覽列右邊按鈕
        
        let rightButton = UIBarButtonItem(
            title:s,
            style:.plain,
            target:self,
            action:#selector(ViewController.checkIn))
        // 加到導覽列中
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func checkIn() {
        if(self.checkIsMember()){
            FirebaseManager.getMemberDate()
            if(FirebaseManager.getUserId() != nil && FirebaseManager.getUserPoint() != nil){
                if(FirebaseManager.getUserPoint() == 0){
                    FirebaseManager.addMemberDateToFirebase(point: 100)
                }else{
                    var point : Int = FirebaseManager.getUserPoint()
                    self.checkLoginTime()
                    FirebaseManager.getMemberDate()
                }
                
            }else{
                FirebaseManager.addMemberDateToFirebase(point: 100)
                FirebaseManager.getMemberDate()
            }
            
        }
        
    }
    
    
    
    func setRightButton(s: String){
        // 導覽列右邊按鈕
        
        let LeftButton = UIBarButtonItem(
            title:s,
            style:.plain,
            target:self,
            action:#selector(ViewController.setting))
        // 加到導覽列中
        self.navigationItem.leftBarButtonItem = LeftButton
    }
    @objc func setting() {
        
        let stroyboard = UIStoryboard(name: "Main", bundle: nil);
        let HomeVc = stroyboard.instantiateViewController(withIdentifier: "member")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.window?.rootViewController = HomeVc
        
    } 
    
    func setAlert(){
        let controller = UIAlertController(title: "訪客身份", message: "請先登入再使用", preferredStyle: .actionSheet)
        let names = ["去登入"]
        for name in names {
            let user = Auth.auth().currentUser
            
            user?.delete { error in
                if let error = error {
                    // An error happened.
                } else {
                    // Account deleted.
                }
            }
            self.userDefaults.set(nil, forKey: "userID")
            
            let action = UIAlertAction(title: name, style: .default) { (action) in
                let stroyboard = UIStoryboard(name: "Main", bundle: nil);
                let HomeVc = stroyboard.instantiateViewController(withIdentifier: "login")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate;
                appDelegate.window?.rootViewController = HomeVc
                
            }
            controller.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }

    func getProductIdentifier(name : String){
        switch name {
        case "richman":
            break
        case "MenberPoint_1000":
            FirebaseManager.addMemberBuyPoint(pont: 1000)
            
            //1000
            break
            
        case "Member_Point_1000":
            // 500
            FirebaseManager.addMemberBuyPoint(pont: 500)
            
            break
            
        default:
            break
        }
        
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
    @IBOutlet weak var smallstock: UIView!
    
    @IBOutlet weak var sharelist: UIView!
    func setUIView(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.CurrentPrice.addGestureRecognizer(gesture)
        
        let payme = UITapGestureRecognizer(target: self, action:  #selector(self.paymeAction))
        self.paymeView.addGestureRecognizer(payme)
        
        let news = UITapGestureRecognizer(target: self, action:  #selector(self.newsAction))
        self.newsView.addGestureRecognizer(news)
        
        
        let tomorrow = UITapGestureRecognizer(target: self, action:  #selector(self.tomorrowAction))
        self.todayView.addGestureRecognizer(tomorrow)
        
        let margin = UITapGestureRecognizer(target: self, action:  #selector(self.marginAction))
            self.MarginView.addGestureRecognizer(margin)
        let other = UITapGestureRecognizer(target: self, action:  #selector(self.otherAction))
                 self.mOtherView.addGestureRecognizer(other)
        
        let financing = UITapGestureRecognizer(target: self, action:  #selector(self.financingAction))
        self.FinancingView.addGestureRecognizer(financing)
        
        let small = UITapGestureRecognizer(target: self, action:  #selector(self.smallAction))
        self.smallstock.addGestureRecognizer(small)
        
        
        let share = UITapGestureRecognizer(target: self, action:  #selector(self.shareAction))
        self.sharelist.addGestureRecognizer(share)
        
    }
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
        setJump(type: "CurrentPrice")
    }
    
    @objc func paymeAction(sender : UITapGestureRecognizer) {

        setJump(type: "iap")

    }
    @objc func newsAction(sender : UITapGestureRecognizer) {
         setJump(type: "news")
      }
    @objc func tomorrowAction(sender : UITapGestureRecognizer) {
       setJump(type: "tomorrow")
    }
    @objc func marginAction(sender : UITapGestureRecognizer) {
        setJump(type: "margin")
     }
    
    @objc func otherAction(sender : UITapGestureRecognizer) {
           setJump(type: "other")
        }
    
    @objc func financingAction(sender : UITapGestureRecognizer) {
             setJump(type: "financing")
          }
    
    @objc func smallAction(sender : UITapGestureRecognizer) {
        setJump(type: "report")
            
          }
    @objc func shareAction(sender : UITapGestureRecognizer) {
        setJump(type: "share")

          }
  func getStockcomuperAllDate(){
        Database.database().reference().child("stockcomuper").child("stockcomuper" as! String).observe(.childAdded, with: {
            (snapshot) in
            // childAdded逐筆呈現
            if let dictionaryData = snapshot.value as? [String: AnyObject]{
                var announcement : String = dictionaryData["announcement"] as! String
                self.strings = [announcement]
                self.marqueeLabel.text = self.strings[Int(arc4random_uniform(UInt32(self.strings.count)))]

            }
            
        }, withCancel: nil)
    }
    

}

